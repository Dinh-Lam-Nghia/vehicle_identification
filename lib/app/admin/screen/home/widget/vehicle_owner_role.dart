import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vehicle_identification/generated/l10n.dart';

class VehicleOwnerRole extends StatelessWidget {
  const VehicleOwnerRole({super.key});

  @override
  Widget build(BuildContext context) {
    List<ChartData> chartData(BuildContext context) {
      return [
        ChartData(S.of(context).staff, 25),
        ChartData(S.of(context).visitor, 38),
        ChartData(S.of(context).member, 34),
        ChartData(S.of(context).otherPeople, 52)
      ];
    }

    return SfCircularChart(
      series: <CircularSeries>[
        PieSeries<ChartData, String>(
          dataSource: chartData(context),
          explodeGesture: ActivationMode.singleTap,
          explode: true,
          pointColorMapper: (ChartData data, _) => data.color,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          dataLabelMapper: (ChartData data, _) => data.y.toString(),
          dataLabelSettings: const DataLabelSettings(
              isVisible: true, textStyle: TextStyle(color: Colors.white)),
        )
      ],
      legend: const Legend(isVisible: true, position: LegendPosition.bottom),
      title: ChartTitle(
        text: S.of(context).vehicleOwnerRole.toUpperCase(),
        textStyle: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}
