// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_identification/generated/l10n.dart';
import 'package:vehicle_identification/screen/login/user/screen/user_login_screen.dart';
import 'package:vehicle_identification/screen/information/about_us_screen.dart';
import 'package:vehicle_identification/screen/information/privacy_policy_screen.dart';
import 'package:vehicle_identification/utils/app_color.dart';
import 'package:vehicle_identification/utils/app_provider.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> icons = const [
      FaIcon(
        FontAwesomeIcons.infoCircle,
        color: AppColor.blue4,
      ),
      FaIcon(
        FontAwesomeIcons.book,
        color: AppColor.blue4,
      ),
      FaIcon(
        FontAwesomeIcons.globeAsia,
        color: AppColor.blue4,
      ),
      FaIcon(
        FontAwesomeIcons.powerOff,
        color: AppColor.blue4,
      )
    ];

    List<String> getTitles() {
      List<String> titles = [
        S.of(context).aboutUS,
        S.of(context).privacyPolicy,
        S.of(context).changeLanguage,
        S.of(context).logout,
      ];
      return titles;
    }

    onTap(int index) async {
      if (index == 0) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AboutUsScreen()));
      } else if (index == 1) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const PrivacyPolicyScreen()));
      } else if (index == 2) {
        context.read<AppProvider>().changeLocale();
      } else if (index == 3) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const UserLoginScreen()),
          (Route<dynamic> route) => false,
        );
        final GoogleSignIn googleSignIn = GoogleSignIn();
        await googleSignIn.disconnect();
        await FirebaseAuth.instance.signOut();
      }
    }

    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: AppColor.primary,
          elevation: 0,
          title: Text(
            S.of(context).information.toUpperCase(),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: getTitles().length,
              padding: const EdgeInsetsDirectional.all(8),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColor.gray,
                        borderRadius: BorderRadius.circular(5)),
                    child: ListTile(
                      onTap: () {
                        onTap(index);
                      },
                      leading: icons[index],
                      title: Text(
                        getTitles()[index],
                        style:
                            const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ),
                );
              },
            ),
            Text(
              '${S.of(context).version}: 1.0.0',
              style: const TextStyle(fontSize: 16, color: Colors.black),
            )
          ],
        ));
  }
}
