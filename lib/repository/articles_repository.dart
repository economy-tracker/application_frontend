import '../model/article_list_model.dart';
import '../model/article_model.dart';
import '../view/core.dart';

class ArticlesRepository {
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
  Future<ArticleListModel> getImpotantArticleList() async {
    try {
      var res = await dio.get("/articles/important");
      return ArticleListModel(
        currentPage: 1,
        endPage: 1,
        articles: (res.data["articles"] as List)
          .map((routineJson) => ArticleModel.fromJson(routineJson))
          .toList()
      );
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}