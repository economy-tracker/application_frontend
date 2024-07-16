import 'package:flutter/material.dart';

class Block extends StatelessWidget {
  final Widget child;
  const Block({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(width: 1, color: const Color(0xFF3252B9))
      ),
      child: Padding(padding: const EdgeInsets.all(10), child: child)
    );
  }
}
