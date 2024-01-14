import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vehicle_identification/app/utils/app_url.dart';

class UserService {
  Future<bool> loginUser(
      String email, String displayName, String photoURL) async {
    var url = Uri.parse(AppUrl.loginUser);
    var res = await http.post(url,
        body: {"email": email, "name": displayName, 'urlPhoto': photoURL});
    if (res.statusCode == 200) {
      return !jsonDecode(res.body);
    } else {
      throw Exception('Failed to load!');
    }
  }
}
