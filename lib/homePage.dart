import 'package:flutter/material.dart';

class homePage extends StatelessWidget {
  final Color color;
  homePage(this.color);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}