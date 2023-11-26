import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vehicle_identification/model/vehicle.dart';
import 'package:vehicle_identification/utils/app_url.dart';

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
}
