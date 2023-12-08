import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_identification/generated/l10n.dart';
import 'package:vehicle_identification/widget/app_otp.dart';
import 'package:vehicle_identification/widget/app_toast.dart';

class AddVehicleProvider extends ChangeNotifier {
  final TextEditingController _phoneController = TextEditingController();
  TextEditingController get phoneController => _phoneController;
  final TextEditingController _smsCodeController = TextEditingController();
  TextEditingController get smsCodeController => _smsCodeController;
  bool _isVerify = false;
  bool get isVerify => _isVerify;

  int _roleIndex = 0;
  int get roleIndex => _roleIndex;

  String _roleContent = "";
  String get roleContent => _roleContent;

  bool _isSentCode = false;
  bool get isSentCode => _isSentCode;

  bool _verificationFailed = false;
  bool get verificationFailed => _verificationFailed;

  checkPhoneFilled(String value) {
    _isVerify = false;
    notifyListeners();
  }

  String _verificationId = '';
  String get verificationId => _verificationId;

  int _seconds = 30;
  int get seconds => _seconds;

  void startCountdown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        _seconds--;
        notifyListeners();
      } else {
        timer.cancel();
      }
    });
  }

  verifyPhone() {
    _verificationFailed = false;
    _isSentCode = false;
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.verifyPhoneNumber(
      phoneNumber: _phoneController.text.trim(),
      timeout: const Duration(seconds: 30),
      verificationCompleted: (AuthCredential authCredential) {},
      verificationFailed: (authException) {
        _verificationFailed = true;
        notifyListeners();
      },
      codeSent: (String verification, int? forceResendingToken) {
        _isSentCode = true;
        _verificationId = verification;
        // startCountdown();
        notifyListeners();
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    notifyListeners();
  }

  setVerify() {
    _isVerify = !_isVerify;
    _isSentCode = false;
    notifyListeners();
  }

  setSentCode() {
    _isSentCode = _isSentCode;
    notifyListeners();
  }

  setRole(String? value) {
    _roleContent = value!;
    notifyListeners();
  }
}
