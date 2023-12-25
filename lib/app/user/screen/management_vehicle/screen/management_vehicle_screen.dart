import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_identification/generated/l10n.dart';
import 'package:vehicle_identification/app/user/screen/management_vehicle/provider/management_vehicle_provider.dart';
import 'package:vehicle_identification/app/user/screen/management_vehicle/screen/update_vehicle_screen.dart';
import 'package:vehicle_identification/app/utils/app_color.dart';
import 'package:vehicle_identification/widget/app_toast.dart';

class ManagementVehicleScreen extends StatefulWidget {
  const ManagementVehicleScreen({super.key, required this.onTap});
  final VoidCallback onTap;
  @override
  State<ManagementVehicleScreen> createState() =>
      _ManagementVehicleScreenState();
}

class _ManagementVehicleScreenState extends State<ManagementVehicleScreen> {
  final ManagementVehicleProvider _provider = ManagementVehicleProvider();

  @override
  void initState() {
    _provider.getVehicleInfor();
    super.initState();
  }

  Future<void> _showDialog(ManagementVehicleProvider p, String vehicleID) {
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
                    p.onDeleteVehicle(vehicleID);
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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _provider,
      builder: (context, widgets) => Consumer<ManagementVehicleProvider>(
          builder: (context, provider, child) {
        return Scaffold(
            backgroundColor: Colors.grey.shade100,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: AppColor.primary,
              elevation: 0,
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Text(
                S.of(context).managementVehicle.toUpperCase(),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            body: provider.vehicles.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.all(8),
                    shrinkWrap: true,
                    itemCount: provider.vehicles.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColor.gray,
                              borderRadius: BorderRadius.circular(5)),
                          child: ListTile(
                              style: ListTileStyle.drawer,
                              leading: provider.vehicles[index].type == 0
                                  ? const Icon(
                                      FontAwesomeIcons.motorcycle,
                                      color: AppColor.primary,
                                    )
                                  : const FaIcon(
                                      FontAwesomeIcons.car,
                                      color: AppColor.primary,
                                    ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            UpdateVehicleScreen(
                                                vehicle:
                                                    provider.vehicles[index])));
                              },
                              title: Text(provider.vehicles[index].model ?? ''),
                              subtitle: Text(
                                  provider.vehicles[index].vehicleID ?? ''),
                              trailing: IconButton(
                                  onPressed: () {
                                    _showDialog(
                                        provider,
                                        provider.vehicles[index].vehicleID ??
                                            '');
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: AppColor.red,
                                  ))),
                        ),
                      );
                    })
                : Center(
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          widget.onTap();
                        },
                        child: Text(
                          S.of(context).onTapAddVehicle,
                          style: const TextStyle(
                              fontSize: 15,
                              color: AppColor.primary,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColor.primary),
                        )),
                  ));
      }),
    );
  }
}
