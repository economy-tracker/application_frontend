import 'package:application_frontend/view/home/page/article_page.dart';
import 'package:application_frontend/view/home/provider/select_index_provider.dart';
import 'package:application_frontend/view/home/widget/field_tap_button.dart';
import 'package:application_frontend/view/home/widget/line.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'page/main_page.dart';
import '../core.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? summary;

  @override
  void initState() {
    super.initState();
    setSummary();
  }

  Future<void> setSummary() async {
    var res = await dio.get("/summary/phrase");
    setState(() {
      summary = res.data["phrase"];
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> fields = ["메인", ...List.of(categories.keys)];
    List<Widget> homeScreen = [
      MainPage(summaryText: summary??"loading.."),
      ...List.generate(fields.length-1, (index){
        return ArticlePage(field: fields[index+1]);
      })
    ];
    PageController pageController = PageController();
    IndexState indexProvider = context.watch<IndexState>();
    Future.delayed(const Duration(milliseconds: 10), ()=>{
      pageController.jumpToPage(indexProvider.index)
    });

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
                const SizedBox(width: 15),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ListView.builder(
                      itemCount: fields.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: FieldTapButton(
                            index: index,
                            value: fields[index],
                            controller: pageController
                          )
                        );
                      },
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
              ],
            ),
          )
        )
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
          ]
        )
      )
    );
  }
}