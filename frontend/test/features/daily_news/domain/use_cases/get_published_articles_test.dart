import 'package:flutter_test/flutter_test.dart';
import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/use_cases/get_published_articles.dart';

void main() {
  group('GetPublishedArticlesUseCase', () {
    test('returns the published articles', () async {
      final result = await GetPublishedArticlesUseCase()();

      expect(result, isA<DataSuccess>());
      expect(result.data, isNotEmpty);
      for (final article in result.data!) {
        expect(article.title, isNotEmpty);
        expect(article.description, isNotEmpty);
        expect(article.urlToImage, isNotEmpty);
      }
    });
  });
}
