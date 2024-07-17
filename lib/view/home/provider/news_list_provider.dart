import 'package:flutter/material.dart';

import '../../core.dart';

class NewsState extends ChangeNotifier {
  List<NewsData> mainNews = [];
  Map<String, List<NewsData>> fieldNews = {
    "금융" : [],
    "증권" : [],
    "산업" : [],
    "부동산" : []
  };

  Future<void> fetchMain(int index)async {
    for (int i = 0; i < 10; i++){
      mainNews.add(NewsData(title: "temp", contents: "temp", date: "temp", link: "temp"));
    }
    notifyListeners();
  }
  Future<void> fetch(String field, int index) async {
    for (int i = 0; i < 10; i++){
      fieldNews[field]!.add(NewsData(title: "title", contents: "contents", date: "date", link: "link"));
    }
    notifyListeners();
  }
}