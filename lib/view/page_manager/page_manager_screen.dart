import 'dart:async';
import 'package:application_frontend/view/chart/chart_screen.dart';
import 'package:application_frontend/view/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';

class PageManagerScreen extends StatefulWidget {
  const PageManagerScreen({super.key});

  @override
  State<PageManagerScreen> createState() => _PageManagerScreenState();
}

class _PageManagerScreenState extends State<PageManagerScreen> {
  late final PageController _pageController;
  late Timer _timer;
  final List<int> targetHours = [9, 15, 21];
  int selected = 0;

  void _initializeTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      final now = DateTime.now();
      if (targetHours.contains(now.hour) && now.minute == 0) {
        _showDialog();
      }
    });
  }

  void _showDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("신규 뉴스가 추가되었어요!"),
          content: const Text("재시작하여 최신 데이터를 조회하세요."),
          actions: [
            TextButton(
              onPressed: ()=>Restart.restartApp(),
              child: const Text("재시작", style: TextStyle(color: Colors.green))
            ),
            TextButton(
              onPressed: ()=>Navigator.of(context).pop(),
              child: const Text("취소", style: TextStyle(color: Colors.red))
            )
          ]
        );
      }
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _initializeTimer();
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
