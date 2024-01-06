import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_identification/app/user/service/user/vehicle_service.dart';
import 'package:vehicle_identification/generated/l10n.dart';
import 'package:vehicle_identification/app/user/model/vehicle.dart';

class UpdateVehicleProvider extends ChangeNotifier {
  final VehicleService _vehicleService = VehicleService();

  TextEditingController _phoneController = TextEditingController();
  TextEditingController get phoneController => _phoneController;
  final TextEditingController _smsCodeController = TextEditingController();
  TextEditingController get smsCodeController => _smsCodeController;
  bool _isVerify = true;
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

  String _dateRegister = '';
  String get dateRegister => _dateRegister;

  bool _isCheckExpires = false;
  bool get isCheckExpires => _isCheckExpires;

  String _phoneInit = '';

  init(Vehicle vehicle) {
    _phoneController = TextEditingController(text: vehicle.phone);
    _dateRegister = vehicle.expires ?? '';
    MaterialColor convertColor =
        createMaterialColor(Color(int.parse('${vehicle.color}')));
    _mainColor = convertColor;
    _phoneInit = vehicle.phone ?? '';
    _roleIndex = vehicle.role ?? 0;
    checkExpires();
    notifyListeners();
  }

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }

    for (final double strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }

    return MaterialColor(color.value, swatch);
  }

  checkPhoneFilled(String value) {
    if (_phoneInit != value) {
      _isVerify = false;
    } else {
      _isVerify = true;
    }
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

  updateVehicle(String vehicleID) async {
    Color convertedColor = _mainColor![500]!.withAlpha(0xff);
    String finalColor =
        convertedColor.toString().replaceAll('Color(', '').replaceAll(')', '');
    Vehicle vehicle = Vehicle(
        phone: _phoneController.text,
        role: _roleIndex,
        color: finalColor,
        expires: _dateRegister,
        vehicleID: vehicleID);
    await _vehicleService.updateVehicle(vehicle);
    notifyListeners();
  }
}
