import 'package:vehicle_identification/app/admin/model/log_table.dart';
import 'package:vehicle_identification/app/utils/app_url.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestService {
  Future<List<LogsTable>> getRequest() async {
    var url = Uri.parse(AppUrl.getRequest);
    var res = await http.post(url);
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      return body.map((e) => LogsTable.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load!');
    }
  }

  Future<void> removeRequest(String id) async {
    var url = Uri.parse(AppUrl.removeRequest);
    await http.post(url, body: {"id": id.toString()});
  }

  Future<void> accpectRequest(String id) async {
    var url = Uri.parse(AppUrl.accpectRequest);
    await http.post(url, body: {"id": id.toString()});
  }

  Future<void> sendSMS(String phone, String content) async {
    var url = Uri.parse(AppUrl.sendSMS);
    await http.post(url, body: {'phone': phone, 'content': content});
  }
}
