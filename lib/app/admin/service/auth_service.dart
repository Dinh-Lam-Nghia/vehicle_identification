import 'package:vehicle_identification/app/utils/app_url.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthAdmin {
  Future<bool> login(String email, String password) async {
    var url = Uri.parse(AppUrl.login);
    var res =
        await http.post(url, body: {'email': email, 'password': password});
    if (res.statusCode == 200) {
      if (jsonDecode(res.body)['message'] == "Login failed") {
        return false;
      }
      return true;
    } else {
      throw Exception('Failed to load!');
    }
  }
}
