import '../model/graph_dot_model.dart';
import '../view/core.dart';

class LineChartRepository {
  Future<List<GraphDotModel>> getDotList(String category) async {
    try {
      var res = await dio.get(
        "/articles/graph",
        queryParameters: {"category" : category}
      );
      List<GraphDotModel> result = [];
      for (int i = 0; i < res.data.length; i++){
        result.add(GraphDotModel.fromJson(res.data[i]));
      }
      return result;
    } catch(error) {
      throw Exception(error.toString());
    }
  }
}