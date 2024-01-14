import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:vehicle_identification/generated/l10n.dart';

class VehicleLocation extends StatelessWidget {
  const VehicleLocation(
      {super.key, required this.countInside, required this.countOutside});
  final int countInside;
  final int countOutside;
  @override
  Widget build(BuildContext context) {
    List<ChartData> data(BuildContext context) {
      List<ChartData> tmp = [
        ChartData(S.of(context).inside, countInside),
        ChartData(S.of(context).outside, countOutside),
      ];
      return tmp;
    }

    return Center(
      child: SfCircularChart(
          title: ChartTitle(
            text: S.of(context).vehicleLocation.toUpperCase(),
            textStyle: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          legend:
              const Legend(isVisible: true, position: LegendPosition.bottom),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <CircularSeries<ChartData, String>>[
            DoughnutSeries<ChartData, String>(
              explode: true,
              explodeIndex: 0,
              dataSource: data(context),
              xValueMapper: (ChartData data, _) => data.title,
              yValueMapper: (ChartData data, _) => data.count,
              dataLabelMapper: (ChartData data, _) => data.count.toString(),
              dataLabelSettings: const DataLabelSettings(
                  isVisible: true, textStyle: TextStyle(color: Colors.white)),
              name: 'Gold',
            )
          ]),
    );
  }
}

class ChartData {
  ChartData(this.title, this.count);
  final String title;
  final int count;
}
