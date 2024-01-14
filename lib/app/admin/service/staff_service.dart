import 'package:vehicle_identification/app/admin/model/log_table.dart';
import 'package:vehicle_identification/app/admin/model/staff.dart';
import 'package:vehicle_identification/app/utils/app_url.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class StaffService {
  Future<List<Staff>> getStaff() async {
    var url = Uri.parse(AppUrl.getStaff);
    var res = await http.post(url);
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      return body.map((e) => Staff.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load!');
    }
  }

  Future<void> removeStaff(int id) async {
    var url = Uri.parse(AppUrl.removeStaff);
    await http.post(url, body: {"id": id.toString()});
  }

  Future<void> addStaff(Staff staff) async {
    var url = Uri.parse(AppUrl.addStaff);
    var body = {
      'phone': staff.phone,
      'plate_number': staff.plateNumber,
      'expires': staff.expires,
      'role': staff.role.toString(),
      'name': staff.name,
      'model': staff.model
    };
    await http.post(url, body: body);
  }

  Future<void> updateStaff(Staff staff) async {
    var url = Uri.parse(AppUrl.updateStaff);
    var body = {
      'id': staff.id.toString(),
      'phone': staff.phone,
      'plate_number': staff.plateNumber,
      'expires': staff.expires,
      'role': staff.role.toString(),
      'name': staff.name,
      'model': staff.model
    };
    await http.post(url, body: body);
  }

  Future<List<Staff>> getStaffs() async {
    var url = Uri.parse(AppUrl.getStaff);
    var res = await http.post(url);
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      return body.map((e) => Staff.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load!');
    }
  }

  Future<List<LogsTable>> getLogTable(int role) async {
    var url = Uri.parse(AppUrl.getLogTable);
    var res = await http.post(url, body: {'role': role.toString()});
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      return body.map((e) => LogsTable.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load!');
    }
  }

  Future<List<LogsTable>> getAllVehicleAdmin(int role) async {
    var url = Uri.parse(AppUrl.getAllVehicleAdmin);
    var res = await http.post(url, body: {'role': role.toString()});
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      return body.map((e) => LogsTable.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load!');
    }
  }

  Future<void> sendSMS(String phone, String content) async {
    var url = Uri.parse(AppUrl.sendSMS);
    await http.post(url, body: {'phone': phone, 'content': content});
  }
}
