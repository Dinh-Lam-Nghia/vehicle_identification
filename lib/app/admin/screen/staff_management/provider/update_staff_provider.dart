import 'package:flutter/material.dart';
import 'package:vehicle_identification/app/admin/model/staff.dart';
import 'package:vehicle_identification/app/admin/service/staff_service.dart';

import 'package:vehicle_identification/generated/l10n.dart';

class UpdateStaffProvider extends ChangeNotifier {
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

  bool _isEnableUpdate = false;
  bool get isEnableUpdate => _isEnableUpdate;

  final StaffService _staffService = StaffService();

  int _idStaff = 0;

  init(Staff staff) {
    _phoneController.text = staff.phone ?? '';
    _modelVehicleController.text = staff.model ?? '';
    _idVehicleController.text = staff.plateNumber ?? '';
    _fullNameController.text = staff.name ?? '';
    _roleIndex = staff.role ?? 0;
    _dateRegister = staff.expires ?? '';
    _idStaff = staff.id ?? 0;
    checkExpires();
    notifyListeners();
  }

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

  updateStaff() async {
    _registerSuccesfull = true;
    Staff staffUpdate = Staff(
        phone: _phoneController.text,
        plateNumber: _idVehicleController.text,
        expires: _dateRegister,
        role: _roleIndex,
        name: _fullNameController.text,
        model: _modelVehicleController.text,
        id: _idStaff);
    _staffService.updateStaff(staffUpdate);
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

  setUpdate() {
    _isEnableUpdate = !_isEnableUpdate;
    notifyListeners();
  }
}
