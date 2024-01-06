import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicle_identification/app/user/model/vehicle.dart';
import 'package:vehicle_identification/app/user/service/user/vehicle_service.dart';

class ManagementVehicleProvider extends ChangeNotifier {
  final VehicleService _vehicleService = VehicleService();

  List<Vehicle> _vehicles = [];
  List<Vehicle> get vehicles => _vehicles;
  getVehicleInfor() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email') ?? '';
    _vehicles = await _vehicleService.getVehicle(email);
    notifyListeners();
  }

  onDeleteVehicle(String vehicleID) {
    _vehicleService.removeVehicle(vehicleID);
    _vehicles.removeWhere((element) => element.vehicleID == vehicleID);
    notifyListeners();
  }
}
