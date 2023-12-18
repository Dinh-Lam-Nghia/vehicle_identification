import 'package:flutter/material.dart';
import 'package:vehicle_identification/app/utils/app_color.dart';

class AppChart extends StatelessWidget {
  const AppChart(
      {super.key,
      required this.text,
      required this.value, required this.color});
  final Color color;
  final String text;
  final int value;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: const [
          BoxShadow(
            color: AppColor.gray,
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: const TextStyle(fontSize: 20, color: AppColor.white),
            ),
            Text(
              value.toString(),
              style: const TextStyle(
                  fontSize: 22,
                  color: AppColor.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
