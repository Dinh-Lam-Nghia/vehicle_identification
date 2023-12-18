import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_identification/app/user/screen/add_vehicle/widget/image_widget.dart';
import 'package:vehicle_identification/generated/l10n.dart';
import 'package:vehicle_identification/app/user/screen/add_vehicle/provider/add_vehicle_provider.dart';
import 'package:vehicle_identification/app/user/screen/add_vehicle/widget/otp_widget.dart';
import 'package:vehicle_identification/app/user/screen/add_vehicle/widget/select_color_widget.dart';
import 'package:vehicle_identification/app/utils/app_color.dart';
import 'package:vehicle_identification/widget/app_button.dart';
import 'package:vehicle_identification/widget/app_dropdown.dart';
import 'package:vehicle_identification/widget/app_input.dart';
import 'package:vehicle_identification/widget/app_toast.dart';

class AddVehicleScreen extends StatefulWidget {
  const AddVehicleScreen({super.key});

  @override
  State<AddVehicleScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddVehicleScreen> {
  final AddVehicleProvider _provider = AddVehicleProvider();
  final _formKey = GlobalKey<FormState>();

  handleVerify(AddVehicleProvider p) {
    if (p.phoneController.text.isEmpty) {
      AppToast().showToast(S.of(context).enterPhoneNumber);
    } else if (p.phoneController.text.length < 12) {
      AppToast().showToast(S.of(context).invalidFormat);
    } else {
      if (!p.isVerify) {
        p.verifyPhone();
      } else {
        AppToast().showToast(S.of(context).verifiedPhoneNumber);
      }
    }
  }

  Widget iconVerifyPhone(AddVehicleProvider p) {
    return IconButton(
        onPressed: () {
          handleVerify(p);
        },
        icon: Icon(
          Icons.verified,
          color: p.isVerify ? AppColor.successColor : AppColor.red,
        ));
  }

  Widget iconVerifyCar(AddVehicleProvider p) {
    return IconButton(
        onPressed: () {
          showDialogImagePicker(p);
        },
        icon: Icon(
          Icons.directions_car,
          color: p.isVerify ? AppColor.successColor : AppColor.red,
        ));
  }

  selectDate(AddVehicleProvider p) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        firstDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        lastDate: p.roleIndex == 0
            ? DateTime(DateTime.now().year, DateTime.now().month + 1,
                DateTime.now().day)
            : DateTime(DateTime.now().year + 1, DateTime.now().month + 6,
                DateTime.now().day),
        locale: Locale(
            S.of(context).localeDate, S.of(context).localeDate.toUpperCase()));
    p.setDate(picked);
    p.checkExpires();
  }

  openColorPicker(AddVehicleProvider p) {
    showDialog(
      context: context,
      builder: (_) {
        return SelectColorWidget(
            mainColor: p.mainColor!,
            setMainColor: p.setMainColor,
            setColor: p.setColor);
      },
    );
  }

  showMyDialogOTP(AddVehicleProvider p) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return OtpWidget(
          codeVetify: p.smsCodeController.text.trim(),
          verificationId: p.verificationId,
          setVerify: p.setVerify,
          verifyPhone: p.verifyPhone,
          setSendCode: p.setSentCode,
        );
      },
    );
  }

  showDialogImagePicker(AddVehicleProvider p) {
    showDialog(
      context: context,
      builder: (_) {
        return ImageWidget(p: p);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<AddVehicleProvider>(
      create: (_) => _provider,
      builder: (context, widgets) {
        return Consumer<AddVehicleProvider>(
            builder: (context, provider, child) {
          Future.delayed(Duration.zero, () {
            if (provider.isSentCode) {
              showMyDialogOTP(provider);
            }
            if (provider.verificationFailed) {
              AppToast().showToast(S.of(context).invalidFormat);
            }
          });
          return Form(
            key: _formKey,
            child: Scaffold(
              backgroundColor: Colors.grey.shade100,
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                backgroundColor: AppColor.primary,
                elevation: 0,
                title: Text(
                  S.of(context).addVehicle.toUpperCase(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              body: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    AppInput(
                        controller: provider.modelVehicleController,
                        width: size.width * 0.9,
                        labelText: S.of(context).model),
                    const SizedBox(
                      height: 30,
                    ),
                    AppInput(
                        controller: provider.phoneController,
                        width: size.width * 0.9,
                        keyboardType: TextInputType.phone,
                        onChange: provider.checkPhoneFilled,
                        labelText: S.of(context).phone,
                        suffixIcon: iconVerifyPhone(provider)),
                    const SizedBox(
                      height: 30,
                    ),
                    AppInput(
                        controller: provider.idVehicleController,
                        width: size.width * 0.9,
                        onChange: provider.checkPhoneFilled,
                        labelText: S.of(context).vehicleId,
                        suffixIcon: iconVerifyCar(provider)),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: size.width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).role,
                            style: const TextStyle(fontSize: 16),
                          ),
                          AppDropdown(
                            listRole: [
                              S.of(context).roleSubDate,
                              S.of(context).roleSubMonth
                            ],
                            value: provider.roleContent.isEmpty
                                ? S.of(context).roleSubDate
                                : provider.roleContent,
                            onChanged: provider.setRole,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: size.width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).color,
                            style: const TextStyle(fontSize: 16),
                          ),
                          InkWell(
                            onTap: () {
                              openColorPicker(provider);
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: provider.mainColor),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: size.width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).expires,
                            style: const TextStyle(fontSize: 16),
                          ),
                          InkWell(
                              onTap: () {
                                selectDate(provider);
                              },
                              child: Text(provider.dateRegister,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: provider.isCheckExpires
                                          ? AppColor.successColor
                                          : AppColor.errorColor,
                                      decoration: TextDecoration.underline,
                                      decorationColor: provider.isCheckExpires
                                          ? AppColor.successColor
                                          : AppColor.errorColor)))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    AppButton(
                        width: size.width * 0.9,
                        text: S.of(context).addVehicle,
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              provider.isVerify) {
                          } else if (provider.isVerify) {
                            AppToast()
                                .showToast(S.of(context).pleaseVerifyPhone);
                          }
                        }),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
