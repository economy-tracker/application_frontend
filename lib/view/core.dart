import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../model/pie_data_model.dart';
import '../repository/base_url.dart';
import '../repository/pie_chart_repository.dart';

TextStyle normal = const TextStyle(color: Colors.white);
TextStyle heading = const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold);
TextStyle bigHeading = const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);
Dio dio = Dio(BaseOptions(baseUrl: baseUrl));

class NewsData {
  final String title;
  final String contents;
  final String date;
  final String link;
  NewsData({required this.title, required this.contents, required this.date, required this.link});
}

Map<String, String> categories = {
  "금융" : "financial",
  "주식" : "stock",
  "산업" : "industry",
  "사업" : "business",
  "자연/환경" : "nature issue",
  "부동산" : "real estate",
  "글로벌" : "global",
  "경제" : "economy",
  "생활 경제" : "living economy",
  "북한" : "north-korea",
  "기타" : "other"
};

String getKeyFromValue(String value) {
  if (value == "others"){
    return "기타";
  }
  for (var categories in categories.entries) {
    if (categories.value == value) {
      return categories.key;
    }
  }
  return "";
}

List<PieDataModel>? pieValues;
List<PieDataModel> nowPopular = [];

Future<void> init() async {
  final PieChartRepository repository = PieChartRepository();
  final fetchedValues = await repository.getDataList();
  pieValues = fetchedValues.map((item) => PieDataModel.clone(item)).toList();
  fetchedValues.removeAt(4);
  fetchedValues.sort((a, b) => b.percent.compareTo(a.percent));
  nowPopular.add(fetchedValues[0]);
  nowPopular.add(fetchedValues[1]);
}