import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vehicle_identification/generated/l10n.dart';
import 'package:vehicle_identification/screen/add_vehicle/provider/add_vehicle_provider.dart';
import 'package:vehicle_identification/utils/app_color.dart';
import 'package:vehicle_identification/utils/app_gif.dart';
import 'package:vehicle_identification/widget/app_lottie.dart';

class ImageWidget extends StatefulWidget {
  const ImageWidget({super.key, required this.p});
  final AddVehicleProvider p;

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  File? _image;
  bool isChecking = false;
  Future selectImage(bool isCamera) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  check() {
    setState(() {
      isChecking = !isChecking;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          S.of(context).verifyVehicle.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      content: !isChecking
          ? SizedBox(
              height: _image == null ? 150 : 280,
              child: Column(
                children: [
                  _image == null
                      ? Text(
                          S.of(context).cameraOrFile,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: AppColor.red),
                        )
                      : Image.file(_image!),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          selectImage(true);
                        },
                        child: const FaIcon(
                          FontAwesomeIcons.camera,
                          color: AppColor.primary,
                          size: 50,
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      InkWell(
                        onTap: () {
                          selectImage(false);
                        },
                        child: const FaIcon(
                          FontAwesomeIcons.folder,
                          color: AppColor.primary,
                          size: 50,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : const AppLottie(assetGif: AppGif.carNumberPlate),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              S.of(context).cancel,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            )),
        TextButton(
            onPressed: () {
              check();
            },
            child: Text(
              S.of(context).confirm,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ))
      ],
    );
  }
}
