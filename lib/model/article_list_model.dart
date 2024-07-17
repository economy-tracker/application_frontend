import 'article_model.dart';

class ArticleListModel {
  int currentPage;
  int endPage;
  List<ArticleModel> articles;

  ArticleListModel({required this.currentPage, required this.endPage, required this.articles});

  factory ArticleListModel.fromJson(Map<String, dynamic> json){
    return ArticleListModel(
      currentPage: json["currentPage"],
      endPage: json["endPage"],
      articles: (json["articles"] as List)
        .map((routineJson) => ArticleModel.fromJson(routineJson))
        .toList()
    );
  }

  ArticleListModel copyWith({int? currentPage, int? endPage, List<ArticleModel>? articles}){
    return ArticleListModel(
        currentPage: currentPage ?? this.currentPage,
        endPage: endPage ?? this.endPage,
        articles: articles ?? this.articles
    );
  }
}