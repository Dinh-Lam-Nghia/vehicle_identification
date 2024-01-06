import 'package:flutter/material.dart';
import 'package:vehicle_identification/app/admin/service/auth_service.dart';

class AdminLoginProvider extends ChangeNotifier {
  final AuthAdmin _authAdmin = AuthAdmin();
  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;
  final TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;
  bool _isLogin = false;
  bool get isLogin => _isLogin;
  Future<void> login() async {
    _isLogin =
        await _authAdmin.login(_emailController.text, _passwordController.text);
    notifyListeners();
  }
}
