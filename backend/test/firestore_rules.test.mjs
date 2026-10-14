import { after, before, beforeEach, describe, it } from 'node:test';
import { assertFails, assertSucceeds } from '@firebase/rules-unit-testing';
import {
  deleteDoc,
  doc,
  getDoc,
  serverTimestamp,
  setDoc,
  Timestamp,
  updateDoc,
} from 'firebase/firestore';
import { createTestEnvironment } from './test_environment.mjs';

const ARTICLE_ID = 'article123';

function validArticle(overrides = {}) {
  return {
    title: 'Breaking News!',
    content: 'This is breaking news!',
    thumbnailURL: `media/articles/${ARTICLE_ID}.jpg`,
    publishedAt: serverTimestamp(),
    ...overrides,
  };
}

describe('Firestore rules: articles', () => {
  let testEnvironment;
  let database;

  before(async () => {
    testEnvironment = await createTestEnvironment();
  });

  beforeEach(async () => {
    await testEnvironment.clearFirestore();
    database = testEnvironment.unauthenticatedContext().firestore();
  });

  after(async () => {
    await testEnvironment.cleanup();
  });

  function articleReference(articleId = ARTICLE_ID) {
    return doc(database, 'articles', articleId);
  }

  async function seedArticle() {
    await testEnvironment.withSecurityRulesDisabled(async (context) => {
      await setDoc(doc(context.firestore(), 'articles', ARTICLE_ID), validArticle());
    });
  }

  it('allows anyone to read an article', async () => {
    await seedArticle();
    await assertSucceeds(getDoc(articleReference()));
  });

  it('allows creating an article that matches the schema', async () => {
    await assertSucceeds(setDoc(articleReference(), validArticle()));
  });

  it('accepts every allowed thumbnail extension', async () => {
    for (const extension of ['jpeg', 'png', 'webp']) {
      const articleId = `article${extension}`;
      const article = validArticle({ thumbnailURL: `media/articles/${articleId}.${extension}` });
      await assertSucceeds(setDoc(articleReference(articleId), article));
    }
  });

  it('accepts a title of exactly 100 characters', async () => {
    await assertSucceeds(setDoc(articleReference(), validArticle({ title: 'a'.repeat(100) })));
  });

  it('accepts a content of exactly 5000 characters', async () => {
    await assertSucceeds(setDoc(articleReference(), validArticle({ content: 'a'.repeat(5000) })));
  });

  it('rejects an article with a missing field', async () => {
    const { content, ...articleWithoutContent } = validArticle();
    await assertFails(setDoc(articleReference(), articleWithoutContent));
  });

  it('rejects an article with an unknown field', async () => {
    await assertFails(setDoc(articleReference(), validArticle({ author: 'Anonymous' })));
  });

  it('rejects a blank title', async () => {
    await assertFails(setDoc(articleReference(), validArticle({ title: '   ' })));
  });

  it('rejects a title longer than 100 characters', async () => {
    await assertFails(setDoc(articleReference(), validArticle({ title: 'a'.repeat(101) })));
  });

  it('rejects a title that is not a string', async () => {
    await assertFails(setDoc(articleReference(), validArticle({ title: 42 })));
  });

  it('rejects a blank content', async () => {
    await assertFails(setDoc(articleReference(), validArticle({ content: '' })));
  });

  it('rejects a content longer than 5000 characters', async () => {
    await assertFails(setDoc(articleReference(), validArticle({ content: 'a'.repeat(5001) })));
  });

  it('rejects a thumbnail outside the media/articles folder', async () => {
    const article = validArticle({ thumbnailURL: `media/other/${ARTICLE_ID}.jpg` });
    await assertFails(setDoc(articleReference(), article));
  });

  it('rejects a thumbnail that belongs to another article', async () => {
    const article = validArticle({ thumbnailURL: 'media/articles/anotherArticle.jpg' });
    await assertFails(setDoc(articleReference(), article));
  });

  it('rejects a thumbnail with an unsupported extension', async () => {
    const article = validArticle({ thumbnailURL: `media/articles/${ARTICLE_ID}.gif` });
    await assertFails(setDoc(articleReference(), article));
  });

  it('rejects a full download URL instead of a storage path', async () => {
    const article = validArticle({
      thumbnailURL: `https://firebasestorage.googleapis.com/media/articles/${ARTICLE_ID}.jpg`,
    });
    await assertFails(setDoc(articleReference(), article));
  });

  it('rejects a publication date chosen by the client', async () => {
    const article = validArticle({ publishedAt: Timestamp.fromDate(new Date('2020-01-01')) });
    await assertFails(setDoc(articleReference(), article));
  });

  it('rejects updating an article', async () => {
    await seedArticle();
    await assertFails(updateDoc(articleReference(), { title: 'Edited title' }));
  });

  it('rejects deleting an article', async () => {
    await seedArticle();
    await assertFails(deleteDoc(articleReference()));
  });

  it('rejects writing to any other collection', async () => {
    await assertFails(setDoc(doc(database, 'users', 'someone'), { name: 'Someone' }));
  });
});
