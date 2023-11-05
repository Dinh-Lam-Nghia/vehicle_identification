// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vehicle_identification/generated/l10n.dart';
import 'package:vehicle_identification/screen/bottom_natigation.dart';
import 'package:vehicle_identification/utils/app_color.dart';
import 'package:vehicle_identification/widget/app_button.dart';
import 'package:vehicle_identification/widget/app_text.dart';

class UserLoggedScreen extends StatelessWidget {
  const UserLoggedScreen({super.key, required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppText(
                text: S.of(context).nameApp,
                color: AppColor.primary,
                fontSize: 40),
            const SizedBox(
              height: 100,
            ),
            Center(
              child: SizedBox(
                height: 180,
                width: 180,
                child: CircleAvatar(
                  radius: 110,
                  backgroundImage: NetworkImage(user.photoURL ?? ''),
                ),
              ),
            ),
            const SizedBox(height: 40),
            AppText(
                text: user.displayName ?? '',
                color: AppColor.primary,
                fontSize: 20),
            const SizedBox(
              height: 100,
            ),
            AppButton(
                width: size.width * 0.8,
                text: S.of(context).continueWithThisAccount,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BottomNavigation()),
                    (Route<dynamic> route) => false,
                  );
                }),
            const SizedBox(
              height: 20,
            ),
            AppButton(
                width: size.width * 0.8,
                text: S.of(context).chooseAnotherAccount,
                onPressed: () async {
                  final GoogleSignIn googleSignIn = GoogleSignIn();
                  await googleSignIn.disconnect();
                  await FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
