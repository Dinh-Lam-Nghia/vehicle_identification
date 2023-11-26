import 'dart:async';

import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;
import 'package:flutter/material.dart';
import 'package:vehicle_identification/screen/login/admin/admin_login_screen.dart';
import 'package:vehicle_identification/screen/login/user/screen/user_login_screen.dart';
import 'package:vehicle_identification/utils/app_color.dart';
import 'package:vehicle_identification/utils/app_gif.dart';

import 'package:vehicle_identification/widget/app_fade_in.dart';
import 'package:vehicle_identification/widget/app_lottie.dart';
import '../../generated/l10n.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final int splashDelay = 4;

  @override
  void initState() {
    super.initState();
    loadWidget();
  }

  Timer loadWidget() {
    var duration = Duration(seconds: splashDelay);
    return Timer(duration, checkPlatform);
  }

  void goToUser() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const UserLoginScreen()));
  }

  void goToAdmin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const AdminLoginScreen()));
  }

  void checkPlatform() {
    if (kIsWeb) {
      goToAdmin();
    } else if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.android) {
      goToUser();
    } else if (defaultTargetPlatform == TargetPlatform.linux ||
        defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.fuchsia) {
      goToAdmin();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: MyFadeIn(
        child: Center(
          child: Column(children: [
            SizedBox(
              height: size.height * 0.25,
            ),
            Text(S.of(context).nameApp,
                style: const TextStyle(
                  color: AppColor.primary,
                  fontSize: 40,
                  fontFamily: 'CarterOne',
                )),
            const SizedBox(
              height: 20,
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    AppLottie(assetGif: AppGif.fastFuriois),
                    Positioned(
                      top: 20,
                      child: AppLottie(
                        assetGif: AppGif.camCctv,
                        height: 80,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ]),
        ),
      ),
    ));
  }
}
