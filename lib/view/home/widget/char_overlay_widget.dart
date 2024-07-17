import 'package:application_frontend/view/home/provider/overlay_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'color_box.dart';

class CharOverlayWidget extends StatelessWidget {
  final String category;
  final Widget chart;
  final Color colorBoxColor;
  const CharOverlayWidget({super.key, required this.category, required this.chart, required this.colorBoxColor});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: const Color(0x00000000),
        child: Stack(
          alignment: Alignment.center,
          children: [
            GestureDetector(
              onTap: (){
                final overlayProvider = context.read<OverlayProvider>();

                overlayProvider.delChartOverlay();
              },
              child: Opacity(
                opacity: 0.5,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: const Color(0xFF000000)
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width - 60,
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('다음 그래프를 통해\n$category 변화를 살펴보세요.', style: const TextStyle(fontSize: 20), textAlign: TextAlign.center),
                      SizedBox(height: 300, child: chart),
                      ColorBox(
                          color: colorBoxColor,
                          field: category
                      )
                    ]
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
