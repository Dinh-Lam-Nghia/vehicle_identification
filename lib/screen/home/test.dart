import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_identification/widget/app_otp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _phoneController = TextEditingController();

  TextEditingController _passController = TextEditingController();

  TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(32),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Login",
              style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 36,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Colors.grey)),
                  filled: true,
                  fillColor: Colors.grey[100],
                  hintText: "Phone Number"),
              controller: _phoneController,
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Colors.grey)),
                  filled: true,
                  fillColor: Colors.grey[100],
                  hintText: "Password"),
              controller: _passController,
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text("Login"),
                onPressed: () {
                  //code for sign in
                  final mobile = _phoneController.text.trim();
                  registerUser(mobile, context);
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Future registerUser(String mobile, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
      phoneNumber: mobile,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (AuthCredential authCredential) {
        _auth.signInWithCredential(authCredential).then((result) {
          print(result);
        }).catchError((e) {
          print(e);
        });
      },
      verificationFailed: (authException) {
        print(authException.message);
      },
      codeSent: (String verificationId, int? forceResendingToken) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
                  title: const Text("Enter SMS Code"),
                  content: AppOTP(
                    codeVetify: _codeController.text.trim(),
                    onSubmit: (value) {
                      FirebaseAuth auth = FirebaseAuth.instance;

                      String smsCode = _codeController.text.trim();

                      var credential = PhoneAuthProvider.credential(
                          verificationId: verificationId, smsCode: smsCode);
                      auth.signInWithCredential(credential).then((result) {
                        print(result);
                        Navigator.pop(context);
                      }).catchError((e) {
                        print(e);
                      });
                    },
                  ),
                  actions: <Widget>[
                    ElevatedButton(
                      child: const Text("Resend"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
