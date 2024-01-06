import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_identification/app/admin/layout/drawer.dart';
import 'package:vehicle_identification/app/admin/layout/nav_bar.dart';
import 'package:vehicle_identification/app/admin/screen/add_staff/provider/provider.dart';

import 'package:vehicle_identification/app/utils/app_color.dart';
import 'package:vehicle_identification/generated/l10n.dart';
import 'package:vehicle_identification/widget/app_button.dart';
import 'package:vehicle_identification/widget/app_dropdown.dart';
import 'package:vehicle_identification/widget/app_input.dart';
import 'package:vehicle_identification/widget/app_responsive.dart';
import 'package:vehicle_identification/widget/app_toast.dart';

class AddStaffScreen extends StatefulWidget {
  const AddStaffScreen({super.key});

  @override
  State<AddStaffScreen> createState() => _AddStaffScreenState();
}

class _AddStaffScreenState extends State<AddStaffScreen> {
  final AddStaffProvider _provider = AddStaffProvider();
  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      large: AddStaff(
        isSmall: false,
        provider: _provider,
      ),
      small: AddStaff(
        isSmall: true,
        provider: _provider,
      ),
      medium: AddStaff(
        isSmall: false,
        provider: _provider,
      ),
    );
  }
}

class AddStaff extends StatefulWidget {
  const AddStaff({super.key, required this.isSmall, required this.provider});
  final bool isSmall;
  final AddStaffProvider provider;
  @override
  State<AddStaff> createState() => _AddStaffState();
}

class _AddStaffState extends State<AddStaff> {
  final _formKey = GlobalKey<FormState>();

  selectDate(AddStaffProvider p) async {
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
    return ChangeNotifierProvider<AddStaffProvider>(
      create: (_) => widget.provider,
      builder: (context, widgets) {
        return Consumer<AddStaffProvider>(builder: (context, provider, child) {
          return Form(
            key: _formKey,
            child: Scaffold(
              backgroundColor: Colors.grey.shade100,
              resizeToAvoidBottomInset: false,
              drawer: const DrawerApp(),
              appBar: NavBar(
                title: S.of(context).addStaff,
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
                        enable: !provider.registerSuccesfull,
                        labelText: S.of(context).fullName),
                    const SizedBox(
                      height: 30,
                    ),
                    AppInput(
                        controller: provider.modelVehicleController,
                        width: widget.isSmall
                            ? size.width * 0.9
                            : size.width * 0.5,
                        enable: !provider.registerSuccesfull,
                        labelText: S.of(context).model),
                    const SizedBox(
                      height: 30,
                    ),
                    AppInput(
                      controller: provider.phoneController,
                      width:
                          widget.isSmall ? size.width * 0.9 : size.width * 0.5,
                      keyboardType: TextInputType.phone,
                      enable: !provider.registerSuccesfull,
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
                      enable: !provider.registerSuccesfull,
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
                            enable: !provider.registerSuccesfull,
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
                                selectDate(widget.provider);
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
                        text: !provider.registerSuccesfull
                            ? S.of(context).addStaff
                            : S.of(context).addAgain,
                        onPressed: () {
                          if (!provider.registerSuccesfull) {
                            if (_formKey.currentState!.validate() &&
                                provider.isCheckExpires) {
                              provider.addStaff();
                              AppToast().showToast(S.of(context).addSuccess);
                            } else if (!provider.isCheckExpires) {
                              AppToast()
                                  .showToast(S.of(context).pleaseSelectDate);
                            }
                          } else {
                            provider.addContinute();
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
