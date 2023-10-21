import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  const AppText(
      {super.key,
      required this.text,
      required this.color,
      required this.fontSize});
  final String text;
  final double fontSize;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(fontFamily: 'CarterOne', fontSize: fontSize, color: color),
    );
  }
}
