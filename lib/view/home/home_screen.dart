import 'package:application_frontend/view/home/widget/field_tap_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> fields = ["메인", "금융", "증권", "산업", "부동산"];
    List<Widget> homeScreen = [];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: 
      PreferredSize(
        preferredSize: const Size.fromHeight(71),
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20),
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
                      return Row(children: [const SizedBox(width: 15), FieldTapButton(index: index, value: fields[index])]);
                    },
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                  ),
                )
              ]
            ),
          ),
        ),
      ),
      body: const Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: PageView.builder(
            itemBuilder:
        );
      )
    );
  }
}