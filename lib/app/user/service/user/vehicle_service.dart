import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:vehicle_identification/app/admin/model/logs.dart';
import 'package:vehicle_identification/app/user/model/vehicle.dart';
import 'package:vehicle_identification/app/utils/app_url.dart';

class VehicleService {
  Future<List<Vehicle>> getVehicle(String email) async {
    var url = Uri.parse(AppUrl.getVehicle);
    var res = await http.post(url, body: {"email": email});
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      return body.map((e) => Vehicle.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load!');
    }
  }

  Future<void> removeVehicle(String vehicleID) async {
    var url = Uri.parse(AppUrl.removeVehicle);
    await http.post(url, body: {"vehicle_id": vehicleID});
  }

  Future<String> verifyVehicle(File image) async {
    final request =
        http.MultipartRequest('POST', Uri.parse(AppUrl.verifyVehicle));
    final header = {"Content-Type": "multipart/form-data"};
    request.files.add(http.MultipartFile(
        'upload', image.readAsBytes().asStream(), image.lengthSync(),
        filename: image.path.split("/").last));
    request.headers.addAll(header);
    final response = await request.send();
    http.Response res = await http.Response.fromStream(response);
    if (res.body.toString().contains('"number_plate"')) {
      final resJson = jsonDecode(res.body);
      return resJson['number_plate'];
    } else {
      return 'Error';
    }
  }

  Future<void> addVehicle(Vehicle vehicle, int userID) async {
    var url = Uri.parse(AppUrl.addVehicle);
    final params = {
      "vehicle_id": vehicle.vehicleID,
      "role": vehicle.role.toString(),
      "vehicle_model": vehicle.model,
      "vehicle_color": vehicle.color,
      "vehicle_type": vehicle.type.toString(),
      "user_id": userID.toString(),
      "expires": vehicle.expires,
      "phone": vehicle.phone
    };
    await http.post(url, body: params);
  }

  Future<void> updateVehicle(Vehicle vehicle) async {
    var url = Uri.parse(AppUrl.updateVehicle);
    final params = {
      "vehicle_id": vehicle.vehicleID,
      "role": vehicle.role.toString(),
      "vehicle_color": vehicle.color,
      "expires": vehicle.expires,
      "phone": vehicle.phone
    };
    await http.post(url, body: params);
  }

  Future<List<Vehicle>> getAllVehicle() async {
    var url = Uri.parse(AppUrl.getAllVehicle);
    var res = await http.post(url);
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      return body.map((e) => Vehicle.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load!');
    }
  }

  Future<List<Logs>> getLogs() async {
    var url = Uri.parse(AppUrl.getLogs);
    var res = await http.post(url);
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      return body.map((e) => Logs.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load!');
    }
  }
}
