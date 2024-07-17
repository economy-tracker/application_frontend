import 'package:flutter/material.dart';

class ColorBox extends StatelessWidget {
  final Color color;
  final String field;
  const ColorBox({super.key, required this.color, required this.field});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 20, height: 20, color: color),
        const SizedBox(width: 15),
        Text(field)
      ],
    );
  }
}
