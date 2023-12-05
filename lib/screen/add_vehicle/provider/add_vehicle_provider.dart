import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddVehicleProvider extends ChangeNotifier {
  final TextEditingController _phoneController = TextEditingController();
  TextEditingController get phoneController => _phoneController;
  final TextEditingController _smsCodeController = TextEditingController();
  TextEditingController get smsCodeController => _smsCodeController;
  bool _isVerify = false;
  bool get isVerify => _isVerify;

  bool _isCheckPhoneFill = false;
  bool get isCheckPhoneFill => _isCheckPhoneFill;

  bool _isCodeSent = false;
  bool get isCodeSent => _isCodeSent;

  String _verificationId = '';
  String get verificationId => _verificationId;

  checkPhoneFilled(String value) {
    if (value.isNotEmpty) {
      _isVerify = false;
      _isCheckPhoneFill = true;
    } else {
      _isCheckPhoneFill = false;
    }
    notifyListeners();
  }

  void verifyPhone(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.verifyPhoneNumber(
      phoneNumber: _phoneController.text.trim(),
      timeout: const Duration(seconds: 60),
      verificationCompleted: (AuthCredential authCredential) {},
      verificationFailed: (authException) {
        print(authException);
      },
      codeSent: (String verificationId, int? forceResendingToken) {
        _isCodeSent = true;
        _verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    notifyListeners();
  }

  void setVerify() {
    _isVerify = !_isVerify;
    notifyListeners();
  }
}
