import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppLottie extends StatelessWidget {
  const AppLottie({super.key, required this.assetGif, this.height});
  final String assetGif;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Lottie.asset(assetGif, height: height);
  }
}
