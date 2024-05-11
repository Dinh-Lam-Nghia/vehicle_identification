import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_identification/app/admin/layout/drawer.dart';
import 'package:vehicle_identification/app/admin/layout/nav_bar.dart';
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

class AdminHome extends StatefulWidget {
  const AdminHome({super.key, required this.isSmall, required this.provider});
  final bool isSmall;
  final AdminHomeProvider provider;
  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  void initState() {
    widget.provider.init();
    super.initState();
  }

  int crossAxisCount() {
    if (widget.isSmall) {
      return 2;
    }
    return 4;
  }

  List<Chart> chartList(AdminHomeProvider p) {
    List<Chart> chartTmp = [
      Chart(
          title: S.of(context).totalVehicles,
          result: p.vehicles.length + p.staffs.length,
          color: AppColor.purple),
      Chart(
          title: S.of(context).permitExpired,
          result: p.countExpires,
          color: AppColor.errorColor),
      Chart(
          title: S.of(context).totalIn,
          result: p.countCheckIn,
          color: AppColor.successColor),
      Chart(
          title: S.of(context).totalOut,
          result: p.countCheckOut,
          color: AppColor.orange)
    ];
    return chartTmp;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AdminHomeProvider>(
      create: ((context) => widget.provider),
      builder: (context, child) {
        return Consumer<AdminHomeProvider>(builder: (context, p, widgets) {
          return Scaffold(
            backgroundColor: Colors.grey.shade100,
            resizeToAvoidBottomInset: false,
            drawer: const DrawerApp(),
            appBar: NavBar(
              title: S.of(context).statistical,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: chartList(p).length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount(),
                            mainAxisExtent: 100,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20),
                        itemBuilder: (context, index) {
                          return AppChart(
                            text: chartList(p)[index].title,
                            value: chartList(p)[index].result,
                            color: chartList(p)[index].color,
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  p.listSales.isNotEmpty
                      ? DailyScan(
                          logs: p.listSales,
                        )
                      : Container(),
                  const SizedBox(
                    height: 20,
                  ),
                  VehicleOwnerRole(
                    countStaff: p.staffs.length,
                    countVisitor: p.vehicles.length,
                  )
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
