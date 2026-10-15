import 'package:flutter_test/flutter_test.dart';
import 'package:news_app_clean_architecture/core/constants/constants.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/models/article.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entities/article.dart';

void main() {
  group('ArticleModel', () {
    test('is built from the raw data of the news API', () {
      final model = ArticleModel.fromRawData({
        'author': 'Author',
        'title': 'Title',
        'description': 'Description',
        'url': 'https://example.com',
        'urlToImage': 'https://example.com/image.jpg',
        'publishedAt': '2026-10-15T09:30:00Z',
        'content': 'Content',
      });

      expect(model.title, 'Title');
      expect(model.urlToImage, 'https://example.com/image.jpg');
      expect(model.publishedAt, '2026-10-15T09:30:00Z');
    });

    test('uses the default image when the article has none', () {
      expect(ArticleModel.fromRawData({'urlToImage': ''}).urlToImage, kDefaultImage);
      expect(ArticleModel.fromRawData({}).urlToImage, kDefaultImage);
    });

    test('converts to an entity with the same values', () {
      const model = ArticleModel(id: 1, title: 'Title', content: 'Content');

      final entity = model.toEntity();

      expect(entity, isNot(isA<ArticleModel>()));
      expect(entity, const ArticleEntity(id: 1, title: 'Title', content: 'Content'));
    });
  });
}
