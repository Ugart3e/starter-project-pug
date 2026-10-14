import 'package:flutter_test/flutter_test.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entities/article_draft.dart';

void main() {
  ArticleDraftEntity draftWith({
    String title = 'Breaking News!',
    String content = 'This is breaking news!',
    String? thumbnailPath = '/images/thumbnail.jpg',
  }) {
    return ArticleDraftEntity(title: title, content: content, thumbnailPath: thumbnailPath);
  }

  group('ArticleDraftEntity', () {
    test('is ready to publish when title, content and thumbnail are valid', () {
      final draft = draftWith();

      expect(draft.validationErrors, isEmpty);
      expect(draft.isReadyToPublish, isTrue);
    });

    test('accepts a title and a content at their maximum length', () {
      final draft = draftWith(
        title: 'a' * ArticleDraftEntity.maxTitleLength,
        content: 'a' * ArticleDraftEntity.maxContentLength,
      );

      expect(draft.isReadyToPublish, isTrue);
    });

    test('reports an empty title', () {
      expect(draftWith(title: '').validationErrors, [ArticleDraftError.emptyTitle]);
    });

    test('reports a title made only of whitespace as empty', () {
      expect(draftWith(title: '   ').validationErrors, [ArticleDraftError.emptyTitle]);
    });

    test('reports a title longer than the maximum length', () {
      final draft = draftWith(title: 'a' * (ArticleDraftEntity.maxTitleLength + 1));

      expect(draft.validationErrors, [ArticleDraftError.titleTooLong]);
    });

    test('reports an empty content', () {
      expect(draftWith(content: '\n ').validationErrors, [ArticleDraftError.emptyContent]);
    });

    test('reports a content longer than the maximum length', () {
      final draft = draftWith(content: 'a' * (ArticleDraftEntity.maxContentLength + 1));

      expect(draft.validationErrors, [ArticleDraftError.contentTooLong]);
    });

    test('reports a missing thumbnail', () {
      expect(draftWith(thumbnailPath: null).validationErrors, [ArticleDraftError.missingThumbnail]);
    });

    test('reports every error of an empty draft', () {
      final draft = draftWith(title: '', content: '', thumbnailPath: null);

      expect(draft.isReadyToPublish, isFalse);
      expect(draft.validationErrors, [
        ArticleDraftError.emptyTitle,
        ArticleDraftError.emptyContent,
        ArticleDraftError.missingThumbnail,
      ]);
    });

    test('is equal to another draft with the same values', () {
      expect(draftWith(), draftWith());
      expect(draftWith().hashCode, draftWith().hashCode);
      expect(draftWith(), isNot(draftWith(title: 'Another title')));
    });
  });
}
