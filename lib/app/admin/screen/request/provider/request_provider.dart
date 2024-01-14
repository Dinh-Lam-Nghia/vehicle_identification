import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_identification/app/admin/model/log_table.dart';
import 'package:vehicle_identification/app/admin/service/request_service.dart';
import 'package:vehicle_identification/generated/l10n.dart';

class RequestProvider extends ChangeNotifier {
  final RequestService _requestService = RequestService();
  List<LogsTable> _vehicles = [];
  List<LogsTable> get vehicles => _vehicles;
  List<LogsTable> _logsTableTmp = [];

  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;
  init() async {
    _vehicles = await _requestService.getRequest();
    _logsTableTmp = _vehicles;
    notifyListeners();
  }

  removeRequest(String vehicleID) async {
    await _requestService.removeRequest(vehicleID);
    notifyListeners();
  }

  accpectRequest(String vehicleID) async {
    await _requestService.accpectRequest(vehicleID);
    _vehicles.removeWhere((e) => e.vehicleID == vehicleID);
    notifyListeners();
  }

  sendSMS(String phone, String content) async {
    await _requestService.sendSMS(phone, content);
    notifyListeners();
  }

  exportExcel(BuildContext context) {
    var excel = Excel.createExcel();
    var sheet = excel['Sheet1'];
    sheet.setDefaultColumnWidth(20);

    sheet.appendRow([
      TextCellValue(
        S.of(context).no,
      ),
      TextCellValue(
        S.of(context).fullName,
      ),
      TextCellValue(
        S.of(context).phone,
      ),
      TextCellValue(
        S.of(context).licensePlate,
      ),
      TextCellValue(
        S.of(context).model,
      ),
      TextCellValue(
        S.of(context).expires,
      ),
    ]);
    for (int i = 0; i < _vehicles.length; i++) {
      sheet.appendRow([
        TextCellValue(
          '${i + 1}',
        ),
        TextCellValue(
          _vehicles[i].name ?? '',
        ),
        TextCellValue(
          _vehicles[i].phone ?? '',
        ),
        TextCellValue(
          _vehicles[i].vehicleID ?? '',
        ),
        TextCellValue(
          _vehicles[i].model ?? '',
        ),
        TextCellValue(
          _vehicles[i].expries ?? '',
        ),
      ]);
    }
    String time = DateTime.now().toString();
    excel.save(fileName: "request_vehicle$time.xlsx");
    notifyListeners();
  }

  onSearch(String value) {
    _vehicles = _logsTableTmp
        .where((e) =>
            e.phone!.toUpperCase().contains(value.toUpperCase()) ||
            e.name!.toUpperCase().contains(value.toUpperCase()) ||
            e.vehicleID!.toUpperCase().contains(value.toUpperCase()) ||
            e.model!.toUpperCase().contains(value.toUpperCase()) ||
            e.expries!.toUpperCase().contains(value.toUpperCase()))
        .toList();
    notifyListeners();
  }
}
