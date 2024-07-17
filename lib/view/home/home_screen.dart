import 'package:application_frontend/view/home/page/news_page.dart';
import 'package:application_frontend/view/home/widget/field_tap_button.dart';
import 'package:application_frontend/view/home/widget/line.dart';
import 'package:flutter/material.dart';
import 'page/main_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> fields = ["메인", "금융", "증권", "산업", "부동산"];
    List<Widget> homeScreen = [
      const MainPage(summaryText: "태양광으로 온실가스 절감, 신기술 발전 기대"),
      const NewsPage(field: "금융"),
      const NewsPage(field: "증권"),
      const NewsPage(field: "산업"),
      const NewsPage(field: "부동산")
    ];
    PageController pageController = PageController();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(71),
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: AppBar(
            backgroundColor: Colors.black,
            title: Row(
              children: [
                Image.asset("assets/logo.png", height: 40, width: 40),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    itemCount: fields.length,
                    itemBuilder: (context, index){
                      return Row(children: [const SizedBox(width: 15), FieldTapButton(index: index, value: fields[index], controller: pageController,)]);
                    },
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                  )
                )
              ]
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Line(),
            const SizedBox(height: 10),
            Expanded(child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: homeScreen
            ))
          ],
        )
      )
    );
  }
}