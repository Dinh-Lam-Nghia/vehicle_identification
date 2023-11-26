import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:vehicle_identification/utils/app_url.dart';

class UserService {
  Future<bool> loginUser(User user) async {
    var url = Uri.parse(AppUrl.loginUser);
    var res = await http.post(url, body: {
      "email": user.email,
      "name": user.displayName,
      'urlPhoto': user.photoURL
    });
    if (res.statusCode == 200) {
      return !jsonDecode(res.body);
    } else {
      throw Exception('Failed to load!');
    }
  }
}
