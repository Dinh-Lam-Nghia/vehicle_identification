// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vehicle_identification/generated/l10n.dart';
import 'package:vehicle_identification/app/user/screen/add_vehicle/screen/add_vehicle_screen.dart';
import 'package:vehicle_identification/app/user/screen/home/home_screen.dart';
import 'package:vehicle_identification/app/user/screen/management_vehicle/screen/management_vehicle_screen.dart';
import 'package:vehicle_identification/app/user/screen/information/information_screen.dart';
import 'package:vehicle_identification/app/utils/app_color.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  navigateToPage2() {
    setState(() {
      _selectedIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> listBottom = [
      BottomNavigationBarItem(
        icon: const FaIcon(
          FontAwesomeIcons.home,
          color: AppColor.blue4,
        ),
        label: S.of(context).home,
      ),
      BottomNavigationBarItem(
          icon: const FaIcon(
            FontAwesomeIcons.circlePlus,
            color: AppColor.blue4,
          ),
          label: S.of(context).addVehicle),
      BottomNavigationBarItem(
          icon: const FaIcon(
            FontAwesomeIcons.car,
            color: AppColor.blue4,
          ),
          label: S.of(context).managementVehicle),
      BottomNavigationBarItem(
          icon: const FaIcon(
            FontAwesomeIcons.infoCircle,
            color: AppColor.blue4,
          ),
          label: S.of(context).information),
    ];

    getPage() {
      switch (_selectedIndex) {
        case 0:
          {
            return HomeScreen(
              onTap: navigateToPage2,
            );
          }
        case 1:
          {
            return const AddVehicleScreen();
          }
        case 2:
          {
            return ManagementVehicleScreen(
              onTap: navigateToPage2,
            );
          }
        case 3:
          {
            return const InformationScreen();
          }
      }
    }

    return Scaffold(
      body: getPage(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColor.primary,
        unselectedItemColor: AppColor.blue3,
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        items: listBottom,
      ),
    );
  }
}
