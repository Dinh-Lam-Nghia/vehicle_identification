import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_identification/app/admin/model/log_table.dart';
import 'package:vehicle_identification/app/admin/service/staff_service.dart';
import 'package:vehicle_identification/generated/l10n.dart';

class AllVehicleProvider extends ChangeNotifier {
  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;
  List<LogsTable> _logsTable = [];
  List<LogsTable> _logsTableTmp = [];
  List<LogsTable> get logsTable => _logsTable;
  final StaffService _staffService = StaffService();

  init() async {
    _logsTableTmp = await _staffService.getAllVehicleAdmin(0);
    _logsTable = await _staffService.getAllVehicleAdmin(1);
    for (var item in _logsTableTmp) {
      _logsTable.add(item);
    }
    _logsTableTmp = _logsTable;
    notifyListeners();
  }

  onSearch(String value) {
    _logsTable = _logsTableTmp
        .where((e) =>
            e.phone!.toUpperCase().contains(value.toUpperCase()) ||
            e.name!.toUpperCase().contains(value.toUpperCase()) ||
            e.vehicleID!.toUpperCase().contains(value.toUpperCase()) ||
            e.model!.toUpperCase().contains(value.toUpperCase()) ||
            e.expries!.toUpperCase().contains(value.toUpperCase()))
        .toList();
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
    for (int i = 0; i < _logsTable.length; i++) {
      sheet.appendRow([
        TextCellValue(
          '${i + 1}',
        ),
        TextCellValue(
          _logsTable[i].name ?? '',
        ),
        TextCellValue(
          _logsTable[i].phone ?? '',
        ),
        TextCellValue(
          _logsTable[i].vehicleID ?? '',
        ),
        TextCellValue(
          _logsTable[i].model ?? '',
        ),
        TextCellValue(
          _logsTable[i].expries ?? '',
        ),
      ]);
    }
    String time = DateTime.now().toString();
    excel.save(fileName: "all_vehicle$time.xlsx");
    notifyListeners();
  }

  checkExpires(String expries) {
    int dateExpires = int.parse(expries.replaceAll('-', ''));
    if (getDate() < dateExpires) {
      return true;
    }
    return false;
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

  sendSms(LogsTable item) async {
    print(item.phone);
    String content =
        'Chào bạn ${item.name}! \nĐăng ký xe của bạn hết hạn vào ${item.expries}. Vui lòng gia hạn ngày đăng ký một lần nữa!';
    await _staffService.sendSMS(item.phone ?? '', content);
    notifyListeners();
  }
}
