import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_identification/generated/l10n.dart';
import 'package:vehicle_identification/app/user/screen/home/provider/home_provider.dart';

import 'package:vehicle_identification/app/user/screen/home/widget/profile_header.dart';
import 'package:vehicle_identification/app/user/screen/home/widget/vehicle_information.dart';
import 'package:vehicle_identification/app/utils/app_color.dart';

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

  Future<void> _showMyDialog(HomeProvider p) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              S.of(context).allVehicle.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                shrinkWrap: true,
                itemCount: p.vehicles.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    style: ListTileStyle.drawer,
                    leading: p.vehicles[index].type == 0
                        ? const Icon(
                            FontAwesomeIcons.motorcycle,
                            color: AppColor.primary,
                          )
                        : const FaIcon(
                            FontAwesomeIcons.car,
                            color: AppColor.primary,
                          ),
                    onTap: () {
                      p.setIndexVehicle(index);
                      Navigator.pop(context);
                    },
                    title: Text(p.vehicles[index].model ?? ''),
                    subtitle: Text(p.vehicles[index].vehicleID ?? ''),
                  );
                }),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => _provider,
        builder: (context, widgets) =>
            Consumer<HomeProvider>(builder: (context, value, child) {
              bool isNotEmpty = value.vehicles.isNotEmpty;
              return Scaffold(
                backgroundColor: Colors.grey.shade100,
                extendBodyBehindAppBar: true,
                extendBody: true,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                floatingActionButton: value.vehicles.length > 1
                    ? FloatingActionButton(
                        backgroundColor: AppColor.lightBlue,
                        onPressed: () {
                          _showMyDialog(value);
                        },
                        child: const Icon(
                          Icons.car_repair,
                          color: AppColor.white,
                        ),
                      )
                    : Container(),
                body: Column(
                  children: [
                    ProfileHeader(
                      user: user!,
                      vehicleID: isNotEmpty
                          ? value.vehicles[value.indexVehicle].vehicleID ?? ''
                          : '',
                      isCheckExpires: value.isCheckExpires,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    isNotEmpty
                        ? Expanded(
                            child: SingleChildScrollView(
                              child: VehicleInformation(
                                  vehicle: value.vehicles[value.indexVehicle],
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
