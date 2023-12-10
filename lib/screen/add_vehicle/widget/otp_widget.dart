import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:vehicle_identification/generated/l10n.dart';
import 'package:vehicle_identification/widget/app_otp.dart';
import 'package:vehicle_identification/widget/app_toast.dart';

class OtpWidget extends StatefulWidget {
  const OtpWidget(
      {super.key,
      required this.codeVetify,
      required this.verificationId,
      required this.setVerify,
      required this.verifyPhone,
      required this.setSendCode});
  final String codeVetify;
  final String verificationId;
  final VoidCallback setVerify;
  final VoidCallback verifyPhone;
  final VoidCallback setSendCode;
  @override
  State<OtpWidget> createState() => _OtpWidgetState();
}

class _OtpWidgetState extends State<OtpWidget> {
  late int _remainingSeconds = 30;
  late Timer _timer;

  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), _updateTimer);
  }

  void _updateTimer(Timer timer) {
    setState(() {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
          child: Text(
        S.of(context).inputOTP.toUpperCase(),
        style: const TextStyle(fontWeight: FontWeight.bold),
      )),
      content: AppOTP(
        onSubmit: (value) {
          FirebaseAuth auth = FirebaseAuth.instance;
          var credential = PhoneAuthProvider.credential(
              verificationId: widget.verificationId, smsCode: value);
          auth.signInWithCredential(credential).then((result) {
            _isError = false;
            widget.setVerify.call();
            Navigator.pop(context);
          }).catchError((e) {
            setState(() {
              _isError = true;
            });
            AppToast().showToast(S.of(context).errorOTP);
          });
        },
        codeVetify: widget.codeVetify,
        isError: _isError,
      ),
      actions: <Widget>[
        TextButton(
          child: Text(S.of(context).cancel),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TimerBuilder.periodic(const Duration(seconds: 1), builder: (context) {
          return TextButton(
            child: Text('${S.of(context).resend} ($_remainingSeconds)s'),
            onPressed: () {
              if (_remainingSeconds == 0) {
                Navigator.pop(context);
                widget.verifyPhone.call();
              } else {
                AppToast().showToast(
                    '${S.of(context).pleaseWait} ($_remainingSeconds)s');
              }
            },
          );
        }),
      ],
    );
  }
}
