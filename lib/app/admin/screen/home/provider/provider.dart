// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:vehicle_identification/app/admin/model/logs.dart';
import 'package:vehicle_identification/app/admin/screen/home/widget/daily_scan.dart';
import 'package:vehicle_identification/app/user/model/vehicle.dart';
import 'package:vehicle_identification/app/user/service/user/vehicle_service.dart';

class AdminHomeProvider extends ChangeNotifier {
  final String _dateRegister = DateTime.now().toString().substring(0, 10);
  String get dateRegister => _dateRegister;

  final VehicleService _vehicleService = VehicleService();
  List<Vehicle> _vehicles = [];
  List<Vehicle> get vehicles => _vehicles;

  List<Logs> _logs = [];
  List<Logs> get logs => _logs;

  int _countExpires = 0;
  int get countExpires => _countExpires;

  int _countCheckIn = 0;
  int get countCheckIn => _countCheckIn;
  int _countCheckOut = 0;
  int get countCheckOut => _countCheckOut;
  final List<ScanData> _listSales = [];
  List<ScanData> get listSales => _listSales;

  init() async {
    _vehicles = await _vehicleService.getAllVehicle();
    _logs = await _vehicleService.getLogs();

    getVehicleExpired();
    setLogs();
    setDailyScan();
    notifyListeners();
  }

  getVehicleExpired() {
    for (int i = 0; i < _vehicles.length; i++) {
      checkExpires(_vehicles[i].expires ?? '');
    }
    notifyListeners();
  }

  setLogs() {
    _countCheckOut =
        _logs.where((element) => element.status == 0).toList().length;
    _countCheckIn = _logs.length - _countCheckOut;
    notifyListeners();
  }

  checkExpires(String date) {
    int dateExpires = int.parse(date.replaceAll('-', ''));
    if (getDate() > dateExpires) _countExpires++;
    notifyListeners();
  }

  setDailyScan() {
    List<String> listTime = [];
    for (int i = 0; i < _logs.length; i++) {
      listTime.add(_logs[i].time ?? '');
    }

    List<String> list = listTime.toSet().toList();

    for (int i = 0; i < list.length; i++) {
      _listSales.add(ScanData(list[i].toString().substring(0, 10),
          _logs.where((element) => element.time == list[i]).toList().length));
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
}
