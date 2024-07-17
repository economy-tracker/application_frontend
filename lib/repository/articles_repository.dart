import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../model/article_list_model.dart';
import 'base_url.dart';

class ArticlesRepository {
  final Dio dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<ArticleListModel> getArticleList(int page, String category) async {
    try {
      var res = await dio.get(
        "/articles",
        queryParameters: {
          "page" : (page+1),
          "category" : category
        }
      );
      return ArticleListModel.fromJson(res.data);
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}