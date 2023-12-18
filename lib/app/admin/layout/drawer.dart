import 'package:flutter/material.dart';
import 'package:vehicle_identification/app/admin/layout/item_drawer.dart';
import 'package:vehicle_identification/app/utils/app_color.dart';

class DrawerApp extends StatelessWidget {
  const DrawerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Drawer(
      backgroundColor: AppColor.primary,
      child: NavigationItems(),
    ));
  }
}
