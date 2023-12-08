import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:vehicle_identification/utils/app_color.dart';

class AppOTP extends StatelessWidget {
  const AppOTP(
      {super.key,
      required this.codeVetify,
      required this.onSubmit,
      required this.isError});
  final String codeVetify;
  final Function(String) onSubmit;
  final bool isError;
  @override
  Widget build(BuildContext context) {
    return OtpTextField(
      numberOfFields: 6,
      borderColor: AppColor.primary,
      showFieldAsBox: true,
      enabledBorderColor: isError ? AppColor.errorColor : Colors.grey,
      onCodeChanged: (String code) {},
      onSubmit: onSubmit,
    );
  }
}
