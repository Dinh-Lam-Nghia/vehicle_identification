import 'package:flutter/material.dart';
import 'package:vehicle_identification/app/utils/app_gif.dart';
import 'package:vehicle_identification/app/utils/app_image.dart';
import 'package:vehicle_identification/widget/app_lottie.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader(
      {super.key,
      required this.vehicleID,
      required this.isCheckExpires,
      required this.urlPhoto,
      required this.userName});
  final String vehicleID;
  final bool isCheckExpires;
  final String userName;
  final String urlPhoto;
  @override
  Widget build(BuildContext context) {
    ImageProvider avatar() {
      if (urlPhoto.isNotEmpty) {
        return NetworkImage(urlPhoto);
      }
      return const AssetImage(AppImage.imgAvatar);
    }

    return Stack(
      children: <Widget>[
        Ink(
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(image: avatar(), fit: BoxFit.cover),
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
                child: AppLottie(
                  assetGif: isCheckExpires
                      ? AppGif.checkAnimation
                      : AppGif.crossAnimation,
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                userName,
                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),
              const SizedBox(height: 5.0),
              Text(
                vehicleID,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        )
      ],
    );
  }
}
