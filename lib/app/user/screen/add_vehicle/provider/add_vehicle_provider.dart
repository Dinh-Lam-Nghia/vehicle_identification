import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_identification/generated/l10n.dart';

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

  ColorSwatch? _tempMainColor;
  ColorSwatch? get tempMainColor => _tempMainColor;
  ColorSwatch? _mainColor = Colors.blue;
  ColorSwatch? get mainColor => _mainColor;

  String _verificationId = '';
  String get verificationId => _verificationId;

  int _seconds = 30;
  int get seconds => _seconds;

  String _dateRegister = DateTime.now().toString().substring(0, 10);
  String get dateRegister => _dateRegister;

  bool _isCheckExpires = false;
  bool get isCheckExpires => _isCheckExpires;

  final TextEditingController _modelVehicleController = TextEditingController();
  TextEditingController get modelVehicleController => _modelVehicleController;

  final TextEditingController _idVehicleController = TextEditingController();
  TextEditingController get idVehicleController => _idVehicleController;

  checkPhoneFilled(String value) {
    _isVerify = false;
    notifyListeners();
  }

  startCountdown() {
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

  setRole(String? value, BuildContext context) {
    _roleContent = value!;
    if (S.of(context).roleSubMonth == value) {
      _roleIndex = 1;
    } else {
      _roleIndex = 0;
    }
    notifyListeners();
  }

  setMainColor(dynamic color) {
    _tempMainColor = color;
    notifyListeners();
  }

  setColor() {
    _mainColor = _tempMainColor;
    notifyListeners();
  }

  setDate(DateTime? picked) {
    _dateRegister = picked.toString().substring(0, 10);
    if (picked != null) {
      _dateRegister = picked.toString().substring(0, 10);
    }
    notifyListeners();
  }

  checkExpires() {
    int dateExpires = int.parse(_dateRegister.replaceAll('-', ''));
    if (getDate() < dateExpires) _isCheckExpires = true;
    notifyListeners();
  }

  getDate() {
    var dateNow = DateTime.now();
    int convertDateNow = 0;
    String day = dateNow.day >= 10 ? dateNow.day.toString() : '0${dateNow.day}';
    String month =
        dateNow.month >= 10 ? dateNow.month.toString() : '0${dateNow.month}';
    convertDateNow = int.parse('${dateNow.year}$month$day');
    return convertDateNow;
  }

  checkRoleRegister() {
    
    notifyListeners();
  }
}
