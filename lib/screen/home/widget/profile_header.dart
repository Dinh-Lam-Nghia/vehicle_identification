import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_identification/utils/app_gif.dart';
import 'package:vehicle_identification/widget/app_lottie.dart';
import 'package:vehicle_identification/widget/app_text.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Ink(
          height: 200,
          decoration:  BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    user.photoURL ?? ''),
                fit: BoxFit.cover),
          ),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 160),
          child: Column(
            children: <Widget>[
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey[100],
                child: const AppLottie(
                  assetGif: AppGif.checkAnimation,
                ),
              ),
              const SizedBox(height: 5.0),
              AppText(
                text: user.displayName ?? '',
                fontSize: 20,
                color: Colors.black,
              ),
              const SizedBox(height: 5.0),
              Text(
                '77K1-34049',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        )
      ],
    );
  }
}
