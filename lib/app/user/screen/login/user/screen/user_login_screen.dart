import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_identification/generated/l10n.dart';
import 'package:vehicle_identification/app/user/screen/login/user/provider/user_login_provider.dart';
import 'package:vehicle_identification/app/user/screen/login/user/screen/user_%20logged_screen.dart';
import 'package:vehicle_identification/app/utils/app_color.dart';
import 'package:vehicle_identification/app/utils/app_image.dart';

import 'package:vehicle_identification/widget/button/app_button_image.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  final UserLoginProvider _provider = UserLoginProvider();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<UserLoginProvider>(
        create: ((context) => _provider),
        builder: (context, child) {
          return Consumer<UserLoginProvider>(
              builder: (context, provider, widget) {
            Future.delayed(Duration.zero, () {
              if (provider.user != null) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserLoggedScreen(
                            user: provider.user!,
                          )),
                  (Route<dynamic> route) => false,
                );
              }
            });
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).nameApp,
                      style: const TextStyle(
                        color: AppColor.primary,
                        fontSize: 40,
                        fontFamily: 'CarterOne',
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Image.asset(AppImage.imgCarHome),
                    const SizedBox(
                      height: 100,
                    ),
                    AppButtonImage(
                      width: size.width * 0.8,
                      text: S.of(context).loginWithGoogle,
                      onPressed: provider.loginWithGoogle,
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }
}
