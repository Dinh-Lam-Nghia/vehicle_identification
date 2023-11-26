import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class AppOTP extends StatelessWidget {
  const AppOTP({super.key, required this.codeVetify, required this.onSubmit});
  final String codeVetify;
  final Function(String) onSubmit;
  @override
  Widget build(BuildContext context) {
    return OtpTextField(
      numberOfFields: 6,
      borderColor: const Color(0xFF512DA8),
      showFieldAsBox: true,
      onCodeChanged: (String code) {},
      onSubmit: onSubmit,
    );
  }
}
