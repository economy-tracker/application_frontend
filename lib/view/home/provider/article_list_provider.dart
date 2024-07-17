import 'package:application_frontend/model/article_list_model.dart';
import 'package:application_frontend/repository/articles_repository.dart';
import 'package:flutter/material.dart';

class ArticleState extends ChangeNotifier {
  ArticlesRepository repository = ArticlesRepository();
  ArticleListModel? mainNews;
  Map<String, ArticleListModel?> fieldNews = {
    "금융" : null,
    "증권" : null,
    "산업" : null,
    "부동산" : null
  };

  Future<void> fetchMain(int index) async {
    if(index == 0){
      mainNews = await repository.getArticleList(index, "economy");
    }

    else {
      if ((mainNews == null) ? false : index > mainNews!.endPage){
        return;
      }
      ArticleListModel response = await repository.getArticleList(index, "economy");
      mainNews!.articles += response.articles;
    }

    debugPrint(mainNews!.articles.length.toString());

    notifyListeners();
  }
  Future<void> fetch(String field, int index) async {
    if ((fieldNews[field] == null) ? false : index > fieldNews[field]!.endPage){
      return;
    }
    fieldNews[field] = await repository.getArticleList(index, translateField(field));
    notifyListeners();
  }
  String translateField(String kr){
    switch (kr){
      case "주요":
        return "economy";
      case "금융":
        return "money";
      default:
        return "economy";
    }
  }
}