import 'package:flutter/material.dart';
import 'package:vehicle_identification/app/admin/model/chart.dart';
import 'package:vehicle_identification/app/admin/screen/home/provider/provider.dart';
import 'package:vehicle_identification/app/admin/screen/home/widget/daily_scan.dart';
import 'package:vehicle_identification/app/admin/screen/home/widget/vehicle_location.dart';
import 'package:vehicle_identification/app/admin/screen/home/widget/vehicle_owner_role.dart';
import 'package:vehicle_identification/app/utils/app_color.dart';
import 'package:vehicle_identification/generated/l10n.dart';
import 'package:vehicle_identification/widget/app_chart.dart';
import 'package:vehicle_identification/widget/app_responsive.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final AdminHomeProvider _provider = AdminHomeProvider();

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      large: AdminHome(
        isSmall: false,
        provider: _provider,
      ),
      small: AdminHome(
        isSmall: true,
        provider: _provider,
      ),
      medium: AdminHome(
        isSmall: false,
        provider: _provider,
      ),
    );
  }
}

class AdminHome extends StatelessWidget {
  const AdminHome({super.key, required this.isSmall, required this.provider});
  final bool isSmall;
  final AdminHomeProvider provider;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    List<Chart> chartList(BuildContext context) {
      List<Chart> chartTmp = [
        Chart(
            title: S.of(context).totalVehicles,
            result: 200,
            color: AppColor.purple),
        Chart(
            title: S.of(context).permitExpired,
            result: 10,
            color: AppColor.errorColor),
        Chart(
            title: S.of(context).totalIn,
            result: 400,
            color: AppColor.successColor),
        Chart(
            title: S.of(context).totalOut, result: 200, color: AppColor.orange)
      ];
      return chartTmp;
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: Text(
          S.of(context).statistical.toUpperCase(),
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: chartList(context).length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isSmall ? 2 : 4,
                      mainAxisExtent: 100,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20),
                  itemBuilder: (context, index) {
                    return AppChart(
                      text: chartList(context)[index].title,
                      value: chartList(context)[index].result,
                      color: chartList(context)[index].color,
                    );
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
            const DailyScan(),
            const SizedBox(
              height: 20,
            ),
            const VehicleLocation(),
            const SizedBox(
              height: 20,
            ),
            const VehicleOwnerRole()
          ],
        ),
      ),
    );
  }
}
