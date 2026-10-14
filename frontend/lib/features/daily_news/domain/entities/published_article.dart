import 'article.dart';

/// An article uploaded by a journalist, shown in the feed next to the
/// articles of the news API.
class PublishedArticleEntity extends ArticleEntity {
  static const int maxDescriptionLength = 150;

  PublishedArticleEntity({
    required String title,
    required String content,
    required String thumbnailUrl,
    required DateTime publishedAt,
  }) : super(
          title: title,
          content: content,
          description: describe(content),
          urlToImage: thumbnailUrl,
          publishedAt: publishedAt.toUtc().toIso8601String(),
        );

  /// Builds the short description shown under the title in the feed:
  /// the beginning of the content, cut at a word boundary.
  static String describe(String content) {
    final singleLineContent = content.trim().replaceAll(RegExp(r'\s+'), ' ');
    if (singleLineContent.length <= maxDescriptionLength) {
      return singleLineContent;
    }
    final truncatedContent = singleLineContent.substring(0, maxDescriptionLength);
    final lastSpaceIndex = truncatedContent.lastIndexOf(' ');
    final wordBoundaryContent =
        lastSpaceIndex > 0 ? truncatedContent.substring(0, lastSpaceIndex) : truncatedContent;
    return '$wordBoundaryContent…';
  }
}
