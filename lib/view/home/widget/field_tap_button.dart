import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/select_index_provider.dart';

class FieldTapButton extends StatefulWidget {
  final int index;
  final String value;
  const FieldTapButton({super.key, required this.index, required this.value});

  @override
  State<FieldTapButton> createState() => _FieldTapButtonState();
}

class _FieldTapButtonState extends State<FieldTapButton> {
  @override
  Widget build(BuildContext context) {
    IndexState indexProvider = context.watch<IndexState>();
    return Center(child: GestureDetector(
      child: Text(widget.value, style: TextStyle(color: (widget.index == indexProvider.index) ? const Color(0xFF3252b9) : Colors.white, fontSize: 20)),
      onTap: ()=>indexProvider.setIndex(widget.index)
    ));
  }
}
