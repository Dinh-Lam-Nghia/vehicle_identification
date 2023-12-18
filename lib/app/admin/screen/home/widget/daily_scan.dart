import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vehicle_identification/generated/l10n.dart';

class DailyScan extends StatelessWidget {
  const DailyScan({super.key});

  @override
  Widget build(BuildContext context) {
    final List<SalesData> chartData = [
      SalesData(DateTime(2023, 1, 20).toString().substring(0, 10), 35),
      SalesData(DateTime(2023, 2, 20).toString().substring(0, 10), 23),
      SalesData(DateTime(2023, 3, 20).toString().substring(0, 10), 34),
      SalesData(DateTime(2023, 4, 20).toString().substring(0, 10), 46),
      SalesData(DateTime(2023, 5, 20).toString().substring(0, 10), 84),
      SalesData(DateTime(2023, 6, 20).toString().substring(0, 10), 22),
      SalesData(DateTime(2023, 7, 20).toString().substring(0, 10), 28),
      SalesData(DateTime(2023, 8, 20).toString().substring(0, 10), 34),
      SalesData(DateTime(2023, 9, 20).toString().substring(0, 10), 21),
      SalesData(DateTime(2023, 10, 20).toString().substring(0, 10), 23),
      SalesData(DateTime(2023, 11, 20).toString().substring(0, 10), 87),
      SalesData(DateTime(2023, 12, 20).toString().substring(0, 10), 24),
    ];

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
          LineSeries<SalesData, String>(
              dataSource: chartData,
              xValueMapper: (SalesData sales, _) => sales.time,
              yValueMapper: (SalesData sales, _) => sales.sales)
        ]);
  }
}

class SalesData {
  SalesData(this.time, this.sales);
  final String time;
  final double sales;
}
