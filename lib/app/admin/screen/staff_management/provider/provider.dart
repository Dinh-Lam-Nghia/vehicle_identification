import 'package:flutter/material.dart';
import 'package:vehicle_identification/app/admin/model/staff.dart';
import 'package:vehicle_identification/app/admin/service/staff_service.dart';

class StaffProvider extends ChangeNotifier {
  final StaffService _staffService = StaffService();
  List<Staff> _staffs = [];
  List<Staff> get staffs => _staffs;

  init() async {
    _staffs = await _staffService.getStaff();

    notifyListeners();
  }

  deleteStaff(int id) async {
    await _staffService.removeStaff(id);
    _staffs.removeWhere(
      (element) => element.id == id,
    );
    notifyListeners();
  }
}
