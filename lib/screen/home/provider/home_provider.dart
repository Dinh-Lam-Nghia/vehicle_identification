import 'package:flutter/material.dart';
import 'package:vehicle_identification/model/vehicle.dart';
import 'package:vehicle_identification/service/user/vehicle_service.dart';

class HomeProvider extends ChangeNotifier {
  final VehicleService _vehicleService = VehicleService();

  List<Vehicle> _vehicles = [];
  List<Vehicle> get vehicles => _vehicles;

  bool _isCheckExpires = false;
  bool get isCheckExpires => _isCheckExpires;

  int _indexVehicle = 0;
  int get indexVehicle => _indexVehicle;

  getVehicleInfor(String email) async {
    _vehicles = await _vehicleService.getVehicle(email);
    if (_vehicles.isNotEmpty) {
      checkExpires();
    }
    notifyListeners();
  }

  checkExpires() {
    int dateExpires =
        int.parse(_vehicles[_indexVehicle].expires!.replaceAll('-', ''));
    if (getDate() < dateExpires) {
      _isCheckExpires = true;
    } else {
      _isCheckExpires = false;
    }
    notifyListeners();
  }

  getDate() {
    var dateNow = DateTime.now();
    int convertDateNow = 0;
    String day = dateNow.day >= 10 ? dateNow.day.toString() : '0${dateNow.day}';
    String month =
        dateNow.month >= 10 ? dateNow.month.toString() : '0${dateNow.month}';
    convertDateNow = int.parse('${dateNow.year}$month$day');
    return convertDateNow;
  }

  setIndexVehicle(int i) {
    _indexVehicle = i;
    checkExpires();
    notifyListeners();
  }
}
