import '../model/pie_data_model.dart';
import '../view/core.dart';

class PieChartRepository {
  Future<List<PieDataModel>> getDataList() async {
    try {
      var res = await dio.get("/articles/chart");
      List<PieDataModel> result = [];
      for (int i = 0; i < res.data.length; i++){
        result.add(PieDataModel.fromJson(res.data[i]));
      }
      return result;
    } catch(error) {
      throw Exception(error.toString());
    }
  }
}