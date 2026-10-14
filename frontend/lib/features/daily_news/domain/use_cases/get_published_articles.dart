import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/core/usecase/usecase.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entities/published_article.dart';

/// Uses mock data until the data layer is implemented (README, section 2.1).
class GetPublishedArticlesUseCase
    implements UseCase<DataState<List<PublishedArticleEntity>>, void> {
  @override
  Future<DataState<List<PublishedArticleEntity>>> call({void params}) async {
    return DataSuccess(_mockPublishedArticles());
  }

  List<PublishedArticleEntity> _mockPublishedArticles() {
    return [
      PublishedArticleEntity(
        title: 'Breaking News!',
        content: 'This is breaking news! The city council has approved a new park '
            'in the city centre. Construction will start next spring and the park '
            'is expected to open to the public within two years.',
        thumbnailUrl: 'https://picsum.photos/seed/symmetry-breaking-news/800/450',
        publishedAt: DateTime.utc(2026, 10, 14, 9, 30),
      ),
      PublishedArticleEntity(
        title: 'Local journalist publishes her first article',
        content: 'Journalists can now upload their own articles to the app, '
            'with a title, a thumbnail and the full story.',
        thumbnailUrl: 'https://picsum.photos/seed/symmetry-first-article/800/450',
        publishedAt: DateTime.utc(2026, 10, 13, 16, 7),
      ),
    ];
  }
}
