import 'package:flutter/material.dart';

TextStyle normal = const TextStyle(color: Colors.white);
TextStyle heading = const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold);

class NewsData {
  final String title;
  final String contents;
  final String date;
  final String link;
  NewsData({required this.title, required this.contents, required this.date, required this.link});
}