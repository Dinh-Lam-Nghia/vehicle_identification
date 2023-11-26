import 'package:flutter/material.dart';
import 'package:vehicle_identification/generated/l10n.dart';
import 'package:vehicle_identification/screen/add_vehicle/add_vehicle_screen.dart';
import 'package:vehicle_identification/screen/home/home_screen.dart';
import 'package:vehicle_identification/screen/setting/setting_screen.dart';
import 'package:vehicle_identification/utils/app_color.dart';

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
        icon: const Icon(Icons.home),
        label: S.of(context).home,
      ),
      BottomNavigationBarItem(
          icon: const Icon(Icons.time_to_leave),
          label: S.of(context).addVehicle),
      BottomNavigationBarItem(
          icon: const Icon(Icons.settings), label: S.of(context).setting),
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
            return const SettingScreen();
          }
      }
    }

    return Scaffold(
      body: getPage(),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColor.white,
        unselectedItemColor: AppColor.blue3,
        backgroundColor: AppColor.primary,
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
