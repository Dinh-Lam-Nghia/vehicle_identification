import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_identification/app/admin/layout/drawer.dart';
import 'package:vehicle_identification/app/admin/layout/nav_bar.dart';
import 'package:vehicle_identification/app/admin/model/staff.dart';
import 'package:vehicle_identification/app/admin/screen/staff_management/provider/update_staff_provider.dart';

import 'package:vehicle_identification/app/utils/app_color.dart';
import 'package:vehicle_identification/generated/l10n.dart';
import 'package:vehicle_identification/widget/app_button.dart';
import 'package:vehicle_identification/widget/app_dropdown.dart';
import 'package:vehicle_identification/widget/app_input.dart';
import 'package:vehicle_identification/widget/app_responsive.dart';
import 'package:vehicle_identification/widget/app_toast.dart';

class UpdateStaffScreen extends StatefulWidget {
  const UpdateStaffScreen({super.key, required this.staff});
  final Staff staff;
  @override
  State<UpdateStaffScreen> createState() => _UpdateStaffScreenState();
}

class _UpdateStaffScreenState extends State<UpdateStaffScreen> {
  final UpdateStaffProvider _provider = UpdateStaffProvider();
  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      large: UpdateStaff(
        isSmall: false,
        provider: _provider,
        staff: widget.staff,
      ),
      small: UpdateStaff(
        isSmall: true,
        provider: _provider,
        staff: widget.staff,
      ),
      medium: UpdateStaff(
        isSmall: false,
        provider: _provider,
        staff: widget.staff,
      ),
    );
  }
}

class UpdateStaff extends StatefulWidget {
  const UpdateStaff(
      {super.key,
      required this.isSmall,
      required this.provider,
      required this.staff});
  final bool isSmall;
  final UpdateStaffProvider provider;
  final Staff staff;
  @override
  State<UpdateStaff> createState() => _UpdateStaffState();
}

class _UpdateStaffState extends State<UpdateStaff> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    widget.provider.init(widget.staff);
    super.initState();
  }

  selectDate(UpdateStaffProvider p) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        firstDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        lastDate: p.roleIndex == 0
            ? DateTime(DateTime.now().year, DateTime.now().month + 1,
                DateTime.now().day)
            : DateTime(DateTime.now().year + 1, DateTime.now().month + 6,
                DateTime.now().day),
        locale: Locale(
            S.of(context).localeDate, S.of(context).localeDate.toUpperCase()));
    p.setDate(picked);
    p.checkExpires();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<UpdateStaffProvider>(
      create: (_) => widget.provider,
      builder: (context, widgets) {
        return Consumer<UpdateStaffProvider>(
            builder: (context, provider, child) {
          return Form(
            key: _formKey,
            child: Scaffold(
              backgroundColor: Colors.grey.shade100,
              resizeToAvoidBottomInset: false,
              drawer: const DrawerApp(),
              appBar: NavBar(
                title: !provider.isEnableUpdate
                    ? S.of(context).detailStaff
                    : S.of(context).updateStaff,
              ),
              body: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    AppInput(
                        controller: provider.fullNameController,
                        width: widget.isSmall
                            ? size.width * 0.9
                            : size.width * 0.5,
                        enable: provider.isEnableUpdate,
                        labelText: S.of(context).fullName),
                    const SizedBox(
                      height: 30,
                    ),
                    AppInput(
                        controller: provider.modelVehicleController,
                        width: widget.isSmall
                            ? size.width * 0.9
                            : size.width * 0.5,
                        enable: provider.isEnableUpdate,
                        labelText: S.of(context).model),
                    const SizedBox(
                      height: 30,
                    ),
                    AppInput(
                      controller: provider.phoneController,
                      width:
                          widget.isSmall ? size.width * 0.9 : size.width * 0.5,
                      keyboardType: TextInputType.phone,
                      enable: provider.isEnableUpdate,
                      labelText: S.of(context).phone,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppInput(
                      controller: provider.idVehicleController,
                      width:
                          widget.isSmall ? size.width * 0.9 : size.width * 0.5,
                      labelText: S.of(context).vehicleId,
                      enable: provider.isEnableUpdate,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width:
                          widget.isSmall ? size.width * 0.9 : size.width * 0.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).role,
                            style: const TextStyle(fontSize: 16),
                          ),
                          AppDropdown(
                            listRole: [
                              S.of(context).roleSubDate,
                              S.of(context).roleSubMonth
                            ],
                            value: provider.roleContent.isEmpty
                                ? S.of(context).roleSubDate
                                : provider.roleContent,
                            onChanged: provider.setRole,
                            enable: provider.isEnableUpdate,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width:
                          widget.isSmall ? size.width * 0.9 : size.width * 0.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).expires,
                            style: const TextStyle(fontSize: 16),
                          ),
                          InkWell(
                              onTap: () {
                                provider.isEnableUpdate
                                    ? selectDate(widget.provider)
                                    : null;
                              },
                              child: Text(provider.dateRegister,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: provider.isCheckExpires
                                          ? AppColor.successColor
                                          : AppColor.errorColor,
                                      decoration: TextDecoration.underline,
                                      decorationColor: provider.isCheckExpires
                                          ? AppColor.successColor
                                          : AppColor.errorColor)))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    AppButton(
                        width: widget.isSmall
                            ? size.width * 0.9
                            : size.width * 0.5,
                        text: !provider.isEnableUpdate
                            ? S.of(context).update
                            : S.of(context).confirm,
                        onPressed: () {
                          if (provider.isEnableUpdate) {
                            if (_formKey.currentState!.validate() &&
                                provider.isCheckExpires) {
                              provider.updateStaff();
                              provider.setUpdate();
                              AppToast().showToast(S.of(context).updateSuccess);
                            } else if (!provider.isCheckExpires) {
                              AppToast()
                                  .showToast(S.of(context).pleaseSelectDate);
                            }
                          } else {
                            provider.setUpdate();
                          }
                        }),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
