import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_identification/service/user/auth_service.dart';

class UserLoginProvider extends ChangeNotifier {
  User? _user;
  User? get user => _user;

  loginWithGoogle() async {
    _user = await Authentication.signInWithGoogle();
    notifyListeners();
  }
}
