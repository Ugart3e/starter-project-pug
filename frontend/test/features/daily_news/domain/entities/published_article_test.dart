import 'package:flutter_test/flutter_test.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entities/published_article.dart';

void main() {
  group('PublishedArticleEntity', () {
    test('maps its values to the fields displayed by the feed', () {
      final article = PublishedArticleEntity(
        title: 'Breaking News!',
        content: 'Short content.',
        thumbnailUrl: 'https://example.com/thumbnail.jpg',
        publishedAt: DateTime.utc(2026, 10, 14, 9, 30),
      );

      expect(article.title, 'Breaking News!');
      expect(article.content, 'Short content.');
      expect(article.description, 'Short content.');
      expect(article.urlToImage, 'https://example.com/thumbnail.jpg');
      expect(article.publishedAt, '2026-10-14T09:30:00.000Z');
    });
  });

  group('PublishedArticleEntity.describe', () {
    test('returns a short content unchanged', () {
      expect(PublishedArticleEntity.describe('Short content.'), 'Short content.');
    });

    test('joins the lines of the content into a single line', () {
      expect(PublishedArticleEntity.describe('  First line.\n\nSecond   line.  '),
          'First line. Second line.');
    });

    test('cuts a long content at a word boundary and adds an ellipsis', () {
      final content = List.filled(40, 'word').join(' ');

      final description = PublishedArticleEntity.describe(content);

      expect(description.length, lessThanOrEqualTo(PublishedArticleEntity.maxDescriptionLength + 1));
      expect(description.endsWith('word…'), isTrue);
    });

    test('cuts a long content without spaces at the maximum length', () {
      final content = 'a' * (PublishedArticleEntity.maxDescriptionLength + 10);

      expect(PublishedArticleEntity.describe(content),
          '${'a' * PublishedArticleEntity.maxDescriptionLength}…');
    });
  });
}
