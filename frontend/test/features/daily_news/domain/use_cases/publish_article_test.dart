import 'package:flutter_test/flutter_test.dart';
import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entities/article_draft.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/use_cases/publish_article.dart';

void main() {
  final publishArticle = PublishArticleUseCase(simulatedDelay: Duration.zero);

  group('PublishArticleUseCase', () {
    test('publishes a draft that is ready to publish', () async {
      const draft = ArticleDraftEntity(
        title: 'Breaking News!',
        content: 'This is breaking news!',
        thumbnailPath: '/images/thumbnail.jpg',
      );

      final result = await publishArticle(params: const PublishArticleParams(draft));

      expect(result, isA<DataSuccess<void>>());
    });

    test('fails with the validation errors of an invalid draft', () async {
      const draft = ArticleDraftEntity(title: '', content: 'Content');

      final result = await publishArticle(params: const PublishArticleParams(draft));

      expect(result, isA<DataFailed<void>>());
      final error = result.error as ArticleDraftValidationException;
      expect(error.errors, [ArticleDraftError.emptyTitle, ArticleDraftError.missingThumbnail]);
    });
  });
}
