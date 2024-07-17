import 'package:application_frontend/view/chart/chart_screen.dart';
import 'package:application_frontend/view/home/home_screen.dart';
import 'package:flutter/material.dart';

class PageManagerScreen extends StatefulWidget {
  const PageManagerScreen({super.key});

  @override
  State<PageManagerScreen> createState() => _PageManagerScreenState();
}

class _PageManagerScreenState extends State<PageManagerScreen> {
  late final PageController _pageController;
  int selected = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const HomeScreen(),
      ChartScreen(),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: pages,
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                selected = 0;
              });
              _pageController.jumpToPage(selected);
            },
            icon: Icon(Icons.home, color: selected == 0 ? const Color(0xFF3252B9) : Colors.white)
          ),
          IconButton(
            onPressed: () {
              setState(() {
                selected = 1;
              });
              _pageController.jumpToPage(selected);
            },
            icon: Icon(Icons.bar_chart_outlined, color: selected == 1 ? const Color(0xFF3252B9) : Colors.white)
          ),
        ],
      ),
    );
  }
}
