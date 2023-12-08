import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_identification/generated/l10n.dart';
import 'package:vehicle_identification/screen/add_vehicle/provider/add_vehicle_provider.dart';
import 'package:vehicle_identification/screen/login/user/widget/otp_widget.dart';
import 'package:vehicle_identification/utils/app_color.dart';
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

  @override
  void initState() {
    super.initState();
  }

  TextEditingController _controller = TextEditingController();

  void handleVerify(AddVehicleProvider p) {
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

  Widget _iconVerify(AddVehicleProvider p) {
    return IconButton(
        onPressed: () {
          handleVerify(p);
        },
        icon: Icon(
          Icons.verified,
          color: p.isVerify ? AppColor.successColor : AppColor.red,
        ));
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
          return Scaffold(
            backgroundColor: Colors.grey.shade100,
            appBar: AppBar(
              backgroundColor: AppColor.primary,
              elevation: 0,
              title: Text(
                S.of(context).addVehicle.toUpperCase(),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      AppInput(
                          controller: _controller,
                          width: size.width * 0.9,
                          labelText: S.of(context).model),
                      const SizedBox(
                        height: 20,
                      ),
                      AppInput(
                          controller: provider.phoneController,
                          width: size.width * 0.9,
                          keyboardType: TextInputType.phone,
                          onChange: provider.checkPhoneFilled,
                          labelText: S.of(context).phone,
                          suffixIcon: _iconVerify(provider)),
                      const SizedBox(
                        height: 20,
                      ),
                      AppInput(
                          controller: _controller,
                          width: size.width * 0.9,
                          labelText: S.of(context).vehicleId),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: size.width * 0.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S.of(context).role,
                              style: const TextStyle(fontSize: 16),
                            ),
                            AppDropdown(
                              listRole: [
                                S.of(context).roleSubDay,
                                S.of(context).roleSubMonth
                              ],
                              value: provider.roleContent.isEmpty
                                  ? S.of(context).roleSubDay
                                  : provider.roleContent,
                              onChanged: provider.setRole,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
