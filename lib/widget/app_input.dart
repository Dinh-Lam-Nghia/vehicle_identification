import 'package:flutter/material.dart';

class AppInput extends StatelessWidget {
  const AppInput(
      {super.key,
      required this.controller,
      this.isObscure,
      required this.labelText,
      this.keyboardType,
      required this.width,
      this.onChange,
      this.enable = true,
      this.suffixIcon});
  final TextEditingController controller;
  final bool? isObscure;
  final String labelText;
  final TextInputType? keyboardType;
  final double? width;
  final Function(String)? onChange;
  final Widget? suffixIcon;
  final bool enable;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return labelText;
          }
          return null;
        },
        obscureText: isObscure ?? false,
        controller: controller,
        onChanged: onChange,
        enabled: enable,
        keyboardType: keyboardType ?? TextInputType.text,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          labelText: labelText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
        ),
      ),
    );
  }
}
