import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicle_identification/app/user/model/user.dart';
import 'package:vehicle_identification/app/user/model/vehicle.dart';
import 'package:vehicle_identification/app/user/service/user/user_sevice.dart';
import 'package:vehicle_identification/app/user/service/user/vehicle_service.dart';
import 'package:vehicle_identification/generated/l10n.dart';

class AddVehicleProvider extends ChangeNotifier {
  final UserService userService = UserService();
  final VehicleService service = VehicleService();
  final TextEditingController _phoneController = TextEditingController();
  TextEditingController get phoneController => _phoneController;
  final TextEditingController _smsCodeController = TextEditingController();
  TextEditingController get smsCodeController => _smsCodeController;
  bool _isVerify = false;
  bool get isVerify => _isVerify;

  bool _isVerifyVehicle = false;
  bool get isVerifyVehicle => _isVerifyVehicle;

  bool _isFailVerifyVehicle = false;
  bool get isFailVerifyVehicle => _isFailVerifyVehicle;

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

  bool _registerSuccesfull = false;
  bool get registerSuccesfull => _registerSuccesfull;

  final TextEditingController _modelVehicleController = TextEditingController();
  TextEditingController get modelVehicleController => _modelVehicleController;

  final TextEditingController _idVehicleController = TextEditingController();
  TextEditingController get idVehicleController => _idVehicleController;

  List<UserProfile> _user = [];
  List<UserProfile> get user => _user;

  getOnlyOneUser(String email) async {
    _user = await userService.getOnlyOneUser(email);
    print(
        "nghia : ${_user[0].id}, ${_user[0].name}, ${_user[0].email}, ${_user[0].photo}, ");
    notifyListeners();
  }

  List<Vehicle> _vehicles = [];
  List<Vehicle> get vehicles => _vehicles;
  final VehicleService _vehicleService = VehicleService();
  getVehicleInfor() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email') ?? '';
    _vehicles = await _vehicleService.getVehicle(email);
    notifyListeners();
  }

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

  Future<bool> check_registered_vehicle(String plateNumber) async {
    for (var item in _vehicles) {
      if (item.vehicleID?.toUpperCase() == plateNumber.toUpperCase()) {
        return true;
      }
    }
    return false;
  }

  Future<bool> verifyVehicle(File image) async {
    ////////////////////////////////////////////
    _isVerifyVehicle = false;
    _isFailVerifyVehicle = false;
    String plateNumber = await service.verifyVehicle(image);
    print("nghia " + plateNumber);
    if (await check_registered_vehicle(plateNumber)) {
      // print("nghia : ${await check_registered_vehicle(plateNumber)}");
      _isFailVerifyVehicle = true;
    } else if (plateNumber == 'Error') {
      _isFailVerifyVehicle = true;
    } else if (_idVehicleController.text.toUpperCase() ==
        plateNumber.toUpperCase()) {
      _isVerifyVehicle = true;
    } else {
      _isFailVerifyVehicle = true;
    }
    notifyListeners();
    return _isVerifyVehicle;
  }

  onChangePlateNumber(String value) {
    _isVerifyVehicle = false;
    notifyListeners();
  }

  addVehicle() async {
    _registerSuccesfull = false;
    Color convertedColor = _mainColor!.withAlpha(0xff);
    String finalColor =
        convertedColor.toString().replaceAll('Color(', '').replaceAll(')', '');
    print("Color : ${finalColor}");
    Vehicle newVehicle = Vehicle(
        vehicleID: _idVehicleController.text,
        role: roleIndex,
        model: _modelVehicleController.text,
        color: finalColor,
        type: 1,
        phone: _phoneController.text,
        expires: _dateRegister);
    await service.addVehicle(newVehicle, int.parse("${_user[0].id}"));
    _registerSuccesfull = true;
    notifyListeners();
  }

  addContinute() {
    _registerSuccesfull = false;
    _isVerify = false;
    _isVerifyVehicle = false;
    _mainColor = Colors.blue;
    _dateRegister = DateTime.now().toString().substring(0, 10);
    _roleIndex = 0;
    _modelVehicleController.text = '';
    _idVehicleController.text = '';
    _phoneController.text = '';
    _isCheckExpires = false;
    checkExpires();
    notifyListeners();
  }
}
