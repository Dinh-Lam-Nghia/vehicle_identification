import 'package:flutter/material.dart';
import 'package:vehicle_identification/app/admin/model/staff.dart';
import 'package:vehicle_identification/app/admin/service/staff_service.dart';

import 'package:vehicle_identification/generated/l10n.dart';

class AddStaffProvider extends ChangeNotifier {
  final TextEditingController _phoneController = TextEditingController();
  TextEditingController get phoneController => _phoneController;

  final TextEditingController _modelVehicleController = TextEditingController();
  TextEditingController get modelVehicleController => _modelVehicleController;

  final TextEditingController _idVehicleController = TextEditingController();
  TextEditingController get idVehicleController => _idVehicleController;

  final TextEditingController _fullNameController = TextEditingController();
  TextEditingController get fullNameController => _fullNameController;
  int _roleIndex = 0;
  int get roleIndex => _roleIndex;

  String _roleContent = "";
  String get roleContent => _roleContent;

  String _dateRegister = DateTime.now().toString().substring(0, 10);
  String get dateRegister => _dateRegister;

  bool _isCheckExpires = false;
  bool get isCheckExpires => _isCheckExpires;

  bool _registerSuccesfull = false;
  bool get registerSuccesfull => _registerSuccesfull;

  final StaffService _staffService = StaffService();

  setRole(String? value, BuildContext context) {
    _roleContent = value!;
    if (S.of(context).roleSubMonth == value) {
      _roleIndex = 1;
    } else {
      _roleIndex = 0;
    }
    notifyListeners();
  }

  setDate(DateTime? picked) {
    _dateRegister = picked.toString().substring(0, 10);
    if (picked != null) {
      _dateRegister = picked.toString().substring(0, 10);
    }
    notifyListeners();
  }

  checkExpires() {
    int dateExpires = int.parse(_dateRegister.replaceAll('-', ''));
    if (getDate() < dateExpires) _isCheckExpires = true;
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

  addStaff() async {
    _registerSuccesfull = true;
    Staff staffAdd = Staff(
        phone: _phoneController.text,
        plateNumber: _idVehicleController.text,
        expires: _dateRegister,
        role: _roleIndex,
        name: _fullNameController.text,
        model: _modelVehicleController.text,
        id: null);
    _staffService.addStaff(staffAdd);
    notifyListeners();
  }

  addContinute() {
    _registerSuccesfull = false;
    _dateRegister = DateTime.now().toString().substring(0, 10);
    _roleIndex = 0;
    _modelVehicleController.text = '';
    _idVehicleController.text = '';
    _phoneController.text = '';
    _isCheckExpires = false;
    _fullNameController.text = '';
    checkExpires();
    notifyListeners();
  }
}
