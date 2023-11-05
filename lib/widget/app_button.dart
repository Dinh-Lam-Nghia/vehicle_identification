import 'package:flutter/material.dart';
import 'package:vehicle_identification/utils/app_color.dart';
import 'package:vehicle_identification/widget/app_text.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {super.key,
      required this.width,
      required this.text,
      required this.onPressed});
  final double width;
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: width,
        decoration: BoxDecoration(
            color: AppColor.primary, borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.center,
        child: AppText(
          text: text,
          color: AppColor.white,
          fontSize: 18,
        ),
      ),
    );
  }
}
