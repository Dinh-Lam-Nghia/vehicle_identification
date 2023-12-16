import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_identification/generated/l10n.dart';
import 'package:vehicle_identification/screen/home/provider/home_provider.dart';

import 'package:vehicle_identification/screen/home/widget/profile_header.dart';
import 'package:vehicle_identification/screen/home/widget/vehicle_information.dart';
import 'package:vehicle_identification/utils/app_color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.onTap});
  final VoidCallback onTap;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final HomeProvider _provider = HomeProvider();

  @override
  void initState() {
    _provider.getVehicleInfor(user!.email ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => _provider,
        builder: (context, widgets) =>
            Consumer<HomeProvider>(builder: (context, value, child) {
              return Scaffold(
                backgroundColor: Colors.grey.shade100,
                extendBodyBehindAppBar: true,
                extendBody: true,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                floatingActionButton: FloatingActionButton(onPressed: () {}),
                body: Column(
                  children: [
                    ProfileHeader(
                      user: user!,
                      vehicleID: value.vehicleInfor!.vehicleID ?? '',
                      isCheckExpires: value.isCheckExpires,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    value.vehicles.isNotEmpty
                        ? Expanded(
                            child: SingleChildScrollView(
                              child: VehicleInformation(
                                  vehicle: value.vehicleInfor!,
                                  isCheckExpires: value.isCheckExpires),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              widget.onTap();
                            },
                            child: Text(
                              S.of(context).onTapAddVehicle,
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: AppColor.primary,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColor.primary),
                            ))
                  ],
                ),
              );
            }));
  }
}
