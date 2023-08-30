class News {
  final String title;
  final String linkOrUrl;
  final String descriptionOrContent;
  final String imageUrl;

  News({
    required this.title,
    required this.linkOrUrl,
    required this.descriptionOrContent,
    this.imageUrl = '',
  });
}
