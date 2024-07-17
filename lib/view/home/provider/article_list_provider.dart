import 'package:application_frontend/model/article_list_model.dart';
import 'package:application_frontend/repository/articles_repository.dart';
import 'package:application_frontend/view/core.dart';
import 'package:flutter/material.dart';

class ArticleState extends ChangeNotifier {
  ArticlesRepository repository = ArticlesRepository();
  ArticleListModel? mainNews;
  Map<String, ArticleListModel?> fieldNews = {};

  Future<void> fetchMain(int index) async {
    mainNews = await repository.getImpotantArticleList();

    notifyListeners();
  }
  Future<void> fetch(String field, int index) async {
    if(index == 0){
      fieldNews[field] = await repository.getArticleList(index, translateField(field));
    }
    else {
      if (index > fieldNews[field]!.endPage){ return; }
      ArticleListModel response = await repository.getArticleList(index, translateField(field));
      fieldNews[field]!.articles += response.articles;
    }

    notifyListeners();
  }
  String translateField(String kr){
    return categories[kr]??"economy";
  }
}