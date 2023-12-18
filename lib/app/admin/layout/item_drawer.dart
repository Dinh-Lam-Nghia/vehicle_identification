import 'package:flutter/material.dart';
import 'package:vehicle_identification/app/admin/screen/add_vehicle/screen/add_vehicle_screen.dart';
import 'package:vehicle_identification/app/admin/screen/all_vehicle/screen/all_vehicle_screen.dart';
import 'package:vehicle_identification/app/admin/screen/home/screen/admin_home_screen.dart';
import 'package:vehicle_identification/app/admin/screen/login/screen/admin_login_screen.dart';
import 'package:vehicle_identification/app/admin/screen/logs/screen/logs_screen.dart';
import 'package:vehicle_identification/app/utils/app_color.dart';
import 'package:vehicle_identification/app/utils/app_image.dart';
import 'package:vehicle_identification/generated/l10n.dart';

class NavigationItems extends StatelessWidget {
  const NavigationItems({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> listTitle(BuildContext context) {
      return [
        S.of(context).statistical,
        S.of(context).logs,
        S.of(context).allVehicle,
        S.of(context).addVehicle,
        S.of(context).logout
      ];
    }

    List listIcon = const [
      Icon(Icons.add_chart, color: AppColor.white),
      Icon(Icons.history, color: AppColor.white),
      Icon(Icons.car_crash, color: AppColor.white),
      Icon(Icons.plus_one, color: AppColor.white),
      Icon(Icons.logout, color: AppColor.white)
    ];
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          S.of(context).nameApp,
          style: const TextStyle(
            color: AppColor.white,
            fontSize: 40,
            fontFamily: 'CarterOne',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Image.asset(AppImage.imgCarHome),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: listTitle(context).length,
          itemBuilder: (BuildContext context, index) {
            return ListTile(
              onTap: () {
                onTap(context, index);
              },
              leading: listIcon[index],
              title: Text(
                listTitle(context)[index],
                style: const TextStyle(fontSize: 16, color: AppColor.white),
              ),
            );
          },
        ),
        const Spacer(),
        Text(
          '${S.of(context).version}: 1.0.0',
          style: const TextStyle(fontSize: 14, color: AppColor.white),
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }

  void onTap(BuildContext context, int index) {
    if (index == 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const AdminHomeScreen()));
    } else if (index == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const LogsScreen()));
    } else if (index == 2) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const AllVehicleScreen()));
    } else if (index == 3) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const AddVehicleScreen()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const AdminLoginScreen()));
    }
  }

}
