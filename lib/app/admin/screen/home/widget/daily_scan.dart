import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vehicle_identification/app/admin/model/logs.dart';
import 'package:vehicle_identification/generated/l10n.dart';

class DailyScan extends StatelessWidget {
  const DailyScan({super.key, required this.logs});
  final List<ScanData> logs;

  @override
  Widget build(BuildContext context) {
    // final List<ScanData> chartData = [
    //   ScanData(DateTime(2023, 1, 20).toString().substring(0, 10), 35),
    //   ScanData(DateTime(2023, 2, 20).toString().substring(0, 10), 23),
    //   ScanData(DateTime(2023, 3, 20).toString().substring(0, 10), 34),
    //   ScanData(DateTime(2023, 4, 20).toString().substring(0, 10), 46),
    //   ScanData(DateTime(2023, 5, 20).toString().substring(0, 10), 84),
    //   ScanData(DateTime(2023, 6, 20).toString().substring(0, 10), 22),
    //   ScanData(DateTime(2023, 7, 20).toString().substring(0, 10), 28),
    //   ScanData(DateTime(2023, 8, 20).toString().substring(0, 10), 34),
    //   ScanData(DateTime(2023, 9, 20).toString().substring(0, 10), 21),
    //   ScanData(DateTime(2023, 10, 20).toString().substring(0, 10), 23),
    //   ScanData(DateTime(2023, 11, 20).toString().substring(0, 10), 87),
    //   ScanData(DateTime(2023, 12, 20).toString().substring(0, 10), 24),
    // ];

    return SfCartesianChart(
        primaryXAxis:
            const CategoryAxis(majorGridLines: MajorGridLines(width: 0)),
        primaryYAxis:
            const NumericAxis(majorGridLines: MajorGridLines(width: 0)),
        tooltipBehavior: TooltipBehavior(enable: true),
        title: ChartTitle(
          text: S.of(context).dailyScan.toUpperCase(),
          textStyle: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        series: <CartesianSeries>[
          LineSeries<ScanData, String>(
              dataSource: logs,
              xValueMapper: (ScanData sales, _) => sales.time,
              yValueMapper: (ScanData sales, _) => sales.sales)
        ]);
  }
}

class ScanData {
  ScanData(this.time, this.sales);
  final String time;
  final int sales;
}
