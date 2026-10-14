import 'package:news_app_clean_architecture/core/resources/data_state.dart';
import 'package:news_app_clean_architecture/core/usecase/usecase.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/entities/published_article.dart';

/// Uses mock data until the data layer is implemented (README, section 2.1).
class GetPublishedArticlesUseCase
    implements UseCase<DataState<List<PublishedArticleEntity>>, void> {
  @override
  Future<DataState<List<PublishedArticleEntity>>> call({void params}) async {
    return DataSuccess(_createMockPublishedArticles());
  }

  List<PublishedArticleEntity> _createMockPublishedArticles() {
    return [
      PublishedArticleEntity(
        title: 'Breaking News!',
        content: 'This is breaking news!  Arnold Scharwezenegger has been seen with '
            'a 20 year old male human in the park.\n'
            'Arnold is 78 years old. will he terminate him?',
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
