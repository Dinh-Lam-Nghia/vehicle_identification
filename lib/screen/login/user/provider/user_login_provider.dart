import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicle_identification/service/user/auth_service.dart';
import 'package:vehicle_identification/service/user/user_sevice.dart';

class UserLoginProvider extends ChangeNotifier {
  User? _user;
  User? get user => _user;

  final UserService _userService = UserService();
  bool _isNewUser = false;
  bool get isNewUser => _isNewUser;

  loginWithGoogle() async {
    _user = await Authentication.signInWithGoogle();
    if (_user != null) {
      setUserLocal();
      loginUser();
    }

    notifyListeners();
  }

  setUserLocal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', _user!.email ?? '');
    await prefs.setString('userName', _user!.displayName ?? '');
    await prefs.setString('photoURL', _user!.photoURL ?? '');
    notifyListeners();
  }

  loginUser() async {
    _isNewUser = await _userService.loginUser(_user!);
    notifyListeners();
  }
}
