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
      const ChartScreen(),
    ];

    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: pages,
      ),
      bottomNavigationBar: Row(
        children: [
          IconButton(
            onPressed: () => _pageController.jumpToPage(0),
            icon: const Icon(Icons.home)),
          IconButton(
            onPressed: () => _pageController.jumpToPage(1),
            icon: const Icon(Icons.home)),
        ],
      ),
    );
  }
}
