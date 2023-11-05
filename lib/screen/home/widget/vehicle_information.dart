import 'package:flutter/material.dart';
import 'package:vehicle_identification/utils/app_color.dart';
import 'package:vehicle_identification/widget/app_text.dart';

class VehicleInformation extends StatelessWidget {
  const VehicleInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppText(
            text: 'Vehicle Information',
            color: AppColor.secondary,
            fontSize: 18)
      ],
    );
  }
}
