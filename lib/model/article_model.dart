class ArticleModel {
  final String title;
  final String description;
  final String category;
  final String pubDate;
  final String link;

  ArticleModel({
    required this.title,
    required this.description,
    required this.category,
    required this.pubDate,
    required this.link,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json){
    return ArticleModel(
      title: json["title"],
      description: json["description"],
      category: json["category"],
      pubDate: json["pubDate"],
      link: json["link"]
    );
  }
}
