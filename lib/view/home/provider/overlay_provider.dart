import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widget/char_overlay_widget.dart';

class OverlayProvider extends ChangeNotifier {
  late OverlayEntry? chartOverlay;

  void setChartOverlay({
    required String category,
    required Widget chart,
    required Color colorBoxColor,
  }) {
    chartOverlay = OverlayEntry(
      builder: (_) => CharOverlayWidget(
        category: category,
        chart: chart,
        colorBoxColor: colorBoxColor,
      ),
    );
  }

  void delChartOverlay(){
    chartOverlay!.remove();
    chartOverlay = null;
  }

  void showChartOverlay(OverlayState overlayState){
    overlayState.insert(chartOverlay!);
  }
}