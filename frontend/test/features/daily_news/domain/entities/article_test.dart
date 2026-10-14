import 'package:flutter_test/flutter_test.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entities/article.dart';

void main() {
  group('ArticleEntity', () {
    const article = ArticleEntity(
      id: 1,
      author: 'Author',
      title: 'Title',
      description: 'Description',
      url: 'https://example.com',
      urlToImage: 'https://example.com/image.jpg',
      publishedAt: '2026-10-14T09:30:00Z',
      content: 'Content',
    );

    test('is equal to another article with the same values', () {
      const sameArticle = ArticleEntity(
        id: 1,
        author: 'Author',
        title: 'Title',
        description: 'Description',
        url: 'https://example.com',
        urlToImage: 'https://example.com/image.jpg',
        publishedAt: '2026-10-14T09:30:00Z',
        content: 'Content',
      );

      expect(article, sameArticle);
      expect(article.hashCode, sameArticle.hashCode);
    });

    test('is not equal to an article with different values', () {
      expect(article, isNot(const ArticleEntity(id: 2, title: 'Title')));
    });
  });
}
