import 'package:application_frontend/view/home/widget/news_widget.dart';
import 'package:flutter/material.dart';
import '../../core.dart';
import '../widget/line.dart';

class NewsPage extends StatelessWidget {
  final String field;
  const NewsPage({super.key, required this.field});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$field 뉴스", style: heading),
        const Line(),
        NewsWidget(),
        /*ListView.builder(
            itemBuilder: (context, index){return CustomListTile();}
        )*/
      ],
    );
  }
}
