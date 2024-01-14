import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_identification/app/admin/model/log_table.dart';
import 'package:vehicle_identification/app/admin/service/staff_service.dart';
import 'package:vehicle_identification/generated/l10n.dart';

class LogProvider extends ChangeNotifier {
  final StaffService _staffService = StaffService();
  List<LogsTable> _logsTable = [];
  List<LogsTable> _logsTableTmp = [];
  List<LogsTable> get logsTable => _logsTable;
  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;
  init() async {
    _logsTableTmp = await _staffService.getLogTable(0);
    _logsTable = await _staffService.getLogTable(1);
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
            e.time!.toUpperCase().contains(value.toUpperCase()))
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
        S.of(context).time,
      ),
      TextCellValue(
        S.of(context).status,
      )
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
          _logsTable[i].time ?? '',
        ),
        TextCellValue(
          _logsTable[i].status == 0
              ? S.of(context).statusOut
              : S.of(context).statusIn,
        ),
      ]);
    }
    String time = DateTime.now().toString();
    excel.save(fileName: "logs_$time.xlsx");
    notifyListeners();
  }
}
