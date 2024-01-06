import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_identification/app/admin/layout/drawer.dart';
import 'package:vehicle_identification/app/admin/layout/nav_bar.dart';
import 'package:vehicle_identification/app/admin/screen/add_staff/screen/add_staff_screen.dart';
import 'package:vehicle_identification/app/admin/screen/staff_management/provider/provider.dart';
import 'package:vehicle_identification/app/admin/screen/staff_management/screen/update_staff_screen.dart';
import 'package:vehicle_identification/app/utils/app_color.dart';
import 'package:vehicle_identification/generated/l10n.dart';
import 'package:vehicle_identification/widget/app_responsive.dart';
import 'package:vehicle_identification/widget/app_toast.dart';

class StaffManagementScreen extends StatefulWidget {
  const StaffManagementScreen({super.key});

  @override
  State<StaffManagementScreen> createState() => _StaffManagementScreenState();
}

class _StaffManagementScreenState extends State<StaffManagementScreen> {
  final StaffProvider _provider = StaffProvider();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ResponsiveContainer(
      large: StaffManagement(
        isSmall: false,
        provider: _provider,
      ),
      small: StaffManagement(
        isSmall: true,
        provider: _provider,
      ),
      medium: StaffManagement(
        isSmall: false,
        provider: _provider,
      ),
    );
  }
}

class StaffManagement extends StatefulWidget {
  const StaffManagement(
      {super.key, required this.isSmall, required this.provider});
  final bool isSmall;
  final StaffProvider provider;
  @override
  State<StaffManagement> createState() => _StaffManagementState();
}

class _StaffManagementState extends State<StaffManagement> {
  @override
  void initState() {
    widget.provider.init();
    super.initState();
  }

  double widthItem(Size size) {
    return widget.isSmall ? size.width * 0.9 : size.width * 0.7;
  }

  Future<void> _showDialog(StaffProvider p, int id) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                S.of(context).confirm.toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            content: Text(
              S.of(context).confirmDelete,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: AppColor.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    S.of(context).cancel,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )),
              TextButton(
                  onPressed: () {
                    p.deleteStaff(id);
                    Navigator.pop(context);
                    AppToast().showToast(S.of(context).deleted);
                  },
                  child: Text(
                    S.of(context).delete,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ))
            ],
          );
        });
  }

  List<Widget> _items(StaffProvider p, Size size) {
    List<Widget> items = [];
    for (int i = 0; i < p.staffs.length; i++) {
      items.add(Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: widthItem(size),
            decoration: BoxDecoration(
                color: AppColor.gray, borderRadius: BorderRadius.circular(5)),
            child: ListTile(
              title: Text(p.staffs[i].name ?? ''),
              subtitle: Text(p.staffs[i].phone ?? ''),
              trailing: IconButton(
                  onPressed: () {
                    _showDialog(p, p.staffs[i].id!);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: AppColor.red,
                  )),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => UpdateStaffScreen(staff: p.staffs[i])));
              },
            ),
          ),
        ),
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<StaffProvider>(
      create: ((context) => widget.provider),
      builder: (context, child) {
        return Consumer<StaffProvider>(builder: (context, p, widget) {
          return Scaffold(
              backgroundColor: Colors.grey.shade100,
              resizeToAvoidBottomInset: false,
              drawer: const DrawerApp(),
              appBar: NavBar(
                title: S.of(context).staffMananement,
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (p.staffs.isNotEmpty)
                    Column(
                      children: _items(p, size),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Center(
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AddStaffScreen()));
                            },
                            child: Text(
                              S.of(context).onTapAddVehicle,
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: AppColor.primary,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColor.primary),
                            )),
                      ),
                    )
                ],
              ));
        });
      },
    );
  }
}
