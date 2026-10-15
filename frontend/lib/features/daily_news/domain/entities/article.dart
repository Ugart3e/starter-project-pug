class ArticleEntity {
  final int ? id;
  final String ? author;
  final String ? title;
  final String ? description;
  final String ? url;
  final String ? urlToImage;
  final String ? publishedAt;
  final String ? content;

  const ArticleEntity({
    this.id,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  /// Full text shown in the detail of the article. The description is only
  /// added when it is not already the beginning of the content, as happens
  /// with the articles published by journalists.
  String get body {
    final text = content ?? '';
    final summary = (description ?? '').replaceFirst(RegExp(r'…$'), '');
    final singleLineText = text.trim().replaceAll(RegExp(r'\s+'), ' ');
    if (summary.isEmpty || singleLineText.startsWith(summary)) {
      return text;
    }
    return '$description\n\n$text';
  }

  @override
  bool operator ==(Object other) {
    return other is ArticleEntity &&
        other.id == id &&
        other.author == author &&
        other.title == title &&
        other.description == description &&
        other.url == url &&
        other.urlToImage == urlToImage &&
        other.publishedAt == publishedAt &&
        other.content == content;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      author,
      title,
      description,
      url,
      urlToImage,
      publishedAt,
      content,
    );
  }
}
