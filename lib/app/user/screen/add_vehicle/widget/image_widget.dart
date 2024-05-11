// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vehicle_identification/app/user/screen/add_vehicle/provider/add_vehicle_provider.dart';
import 'package:vehicle_identification/app/utils/app_color.dart';
import 'package:vehicle_identification/app/utils/app_gif.dart';
import 'package:vehicle_identification/generated/l10n.dart';

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

  bool isFail = false;
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

  checkFail(bool value) {
    setState(() {
      isFail = value;
    });
  }

  onVerify() async {
    if (_image != null) {
      // widget.p.verifyVehicle(_image!);
      check();
      await Future.delayed(const Duration(milliseconds: 500), () {});
      if (await widget.p.verifyVehicle(_image!)) {
        Navigator.pop(context);
      }
      checkFail(widget.p.isFailVerifyVehicle);
      check();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        height: isChecking ? 350 : (_image == null ? 200 : 500),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Center(
              child: SizedBox(
                height: 20,
                child: Text(
                  S.of(context).verifyVehicle.toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            if (_image == null)
              Center(
                child: Text(
                  S.of(context).cameraOrFile,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColor.red),
                ),
              )
            else
              !isChecking
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                          height: 300,
                          width: 300,
                          child: Image.file(
                            _image!,
                            fit: BoxFit.fill,
                          )),
                    )
                  : const Center(
                      child: AppLottie(assetGif: AppGif.carNumberPlate)),
            isFail
                ? !isChecking
                    ? Center(
                        child: Text(
                        S.of(context).verifyVehicleFail,
                        style: const TextStyle(
                            fontSize: 16, color: AppColor.errorColor),
                      ))
                    : Container()
                : Container(),
            const SizedBox(
              height: 15,
            ),
            !isChecking
                ? SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            checkFail(false);
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
                            checkFail(false);
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
                  )
                : Container(),
            const Spacer(),
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                      onPressed: onVerify,
                      child: Text(
                        S.of(context).confirm,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
