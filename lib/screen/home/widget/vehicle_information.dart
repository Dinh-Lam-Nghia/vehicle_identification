import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vehicle_identification/generated/l10n.dart';
import 'package:vehicle_identification/model/vehicle.dart';
import 'package:vehicle_identification/utils/app_color.dart';

class VehicleInformation extends StatelessWidget {
  const VehicleInformation(
      {super.key, required this.vehicle, required this.isCheckExpires});
  final Vehicle vehicle;
  final bool isCheckExpires;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              S.of(context).vehicleInfor,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ),
          Column(
            children: [
              ...ListTile.divideTiles(color: Colors.grey, tiles: [
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: Text(S.of(context).phone),
                  subtitle: Text(vehicle.phone ?? ''),
                ),
                ListTile(
                  leading: const Icon(Icons.date_range),
                  title: Text(S.of(context).expires),
                  subtitle: Text(
                    vehicle.expires ?? '',
                    style:
                        TextStyle(color: !isCheckExpires ? AppColor.red : null),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(S.of(context).role),
                  subtitle: Text(vehicle.role == 0
                      ? S.of(context).roleSubMonth
                      : S.of(context).roleSubDay),
                ),
                ListTile(
                  leading: const FaIcon(
                    FontAwesomeIcons.car,
                  ),
                  title: Text(S.of(context).model),
                  subtitle: Text(vehicle.model ?? ''),
                ),
                ListTile(
                  leading: const Icon(Icons.color_lens),
                  title: Text(S.of(context).color),
                  subtitle: Container(
                      color: Color(int.parse(vehicle.color ?? '0xff000000')),
                      height: 5,
                      width: 10),
                ),
                ListTile(
                  leading: const Icon(Icons.motorcycle),
                  title: Text(S.of(context).typeVehicle),
                  subtitle: Text(vehicle.type == 0
                      ? S.of(context).motorbike
                      : S.of(context).car),
                ),
              ]),
            ],
          )
        ],
      ),
    );
  }
}
