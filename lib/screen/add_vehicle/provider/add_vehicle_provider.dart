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
  checkPhoneFilled(String value) {
    _isVerify = false;
    notifyListeners();
  }

  Future verifyPhone(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.verifyPhoneNumber(
      phoneNumber: _phoneController.text.trim(),
      timeout: const Duration(seconds: 60),
      verificationCompleted: (AuthCredential authCredential) {},
      verificationFailed: (authException) {
        if (authException.toString() ==
            '[firebase_auth/invalid-phone-number] Invalid format.') {
          AppToast().showToast(S.of(context).invalidFormat);
        }
      },
      codeSent: (String verificationId, int? forceResendingToken) {
        _showMyDialogOTP(context, verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    notifyListeners();
  }

  void setVerify() {
    _isVerify = !_isVerify;
    notifyListeners();
  }

  Future<void> _showMyDialogOTP(
      BuildContext context, String verificationId) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: AppOTP(
            onSubmit: (value) {
              FirebaseAuth auth = FirebaseAuth.instance;
              var credential = PhoneAuthProvider.credential(
                  verificationId: verificationId, smsCode: value);
              auth.signInWithCredential(credential).then((result) {
                setVerify();
                Navigator.pop(context);
              }).catchError((e) {});
            },
            codeVetify: _smsCodeController.text.trim(),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("Resend"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void setRole(String? value) {
    _roleContent = value!;
    notifyListeners();
  }
}
