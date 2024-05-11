import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_identification/app/admin/layout/drawer.dart';
import 'package:vehicle_identification/app/admin/layout/nav_bar.dart';
import 'package:vehicle_identification/app/admin/model/log_table.dart';
import 'package:vehicle_identification/app/admin/screen/request/provider/request_provider.dart';

import 'package:vehicle_identification/app/utils/app_color.dart';
import 'package:vehicle_identification/generated/l10n.dart';
import 'package:vehicle_identification/widget/app_input.dart';
import 'package:vehicle_identification/widget/app_responsive.dart';
import 'package:vehicle_identification/widget/app_toast.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  final RequestProvider _provider = RequestProvider();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ResponsiveContainer(
      large: Request(isSmall: false, provider: _provider, width: width),
      small: Request(isSmall: true, provider: _provider, width: width),
      medium: Request(
        isSmall: false,
        provider: _provider,
        width: width,
      ),
    );
  }
}

class Request extends StatefulWidget {
  const Request(
      {super.key,
      required this.isSmall,
      required this.provider,
      required this.width});
  final bool isSmall;
  final RequestProvider provider;
  final double width;
  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  @override
  void initState() {
    widget.provider.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RequestProvider>(
      create: ((context) => widget.provider),
      builder: (context, child) {
        return Consumer<RequestProvider>(builder: (context, p, widgets) {
          return Scaffold(
            backgroundColor: Colors.grey.shade100,
            resizeToAvoidBottomInset: false,
            drawer: const DrawerApp(),
            appBar: NavBar(
              title: S.of(context).managementRequest,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: widget.isSmall
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SizedBox(
                        width: widget.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppInput(
                                controller: p.searchController,
                                labelText: S.of(context).search,
                                onChange: p.onSearch,
                                width: widget.isSmall
                                    ? widget.width * 0.6
                                    : widget.width * 0.3),
                            IconButton(
                                onPressed: () {
                                  p.exportExcel(context);
                                },
                                icon: const Icon(
                                  Icons.download,
                                  color: AppColor.primary,
                                ))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: SizedBox(
                        width: widget.width,
                        child: RequestTableWidget(
                          vehicles: p.vehicles,
                          provider: widget.provider,
                        ),
                      ),
                    )
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

class RequestTableWidget extends StatefulWidget {
  const RequestTableWidget(
      {super.key, required this.vehicles, required this.provider});
  final List<LogsTable> vehicles;
  final RequestProvider provider;

  @override
  State<RequestTableWidget> createState() => _RequestTableWidgetState();
}

class _RequestTableWidgetState extends State<RequestTableWidget> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      sortColumnIndex: _sortColumnIndex,
      sortAscending: _sortAscending,
      columnSpacing: 100,
      rowsPerPage: _rowsPerPage,
      onRowsPerPageChanged: (newRowsPerPage) {
        setState(() {
          _rowsPerPage =
              newRowsPerPage ?? PaginatedDataTable.defaultRowsPerPage;
        });
      },
      columns: <DataColumn>[
        DataColumn(
          label: Text(S.of(context).no),
        ),
        DataColumn(
          label: Text(S.of(context).fullName),
          onSort: (columnIndex, ascending) {
            setState(() {
              _sortColumnIndex = columnIndex;
              _sortAscending = ascending;
              widget.vehicles.sort((a, b) {
                if (_sortAscending) {
                  return a.name!.compareTo(b.name!);
                } else {
                  return b.name!.compareTo(a.name!);
                }
              });
            });
          },
        ),
        DataColumn(
          label: Text(S.of(context).phone),
          onSort: (columnIndex, ascending) {
            setState(() {
              _sortColumnIndex = columnIndex;
              _sortAscending = ascending;
              widget.vehicles.sort((a, b) {
                if (_sortAscending) {
                  return a.phone!.compareTo(b.phone!);
                } else {
                  return b.phone!.compareTo(a.phone!);
                }
              });
            });
          },
        ),
        DataColumn(
          label: Text(S.of(context).licensePlate),
          onSort: (columnIndex, ascending) {
            setState(() {
              _sortColumnIndex = columnIndex;
              _sortAscending = ascending;
              widget.vehicles.sort((a, b) {
                if (_sortAscending) {
                  return a.vehicleID!.compareTo(b.vehicleID!);
                } else {
                  return b.vehicleID!.compareTo(a.vehicleID!);
                }
              });
            });
          },
        ),
        DataColumn(
          label: Text(S.of(context).model),
          onSort: (columnIndex, ascending) {
            setState(() {
              _sortColumnIndex = columnIndex;
              _sortAscending = ascending;
              widget.vehicles.sort((a, b) {
                if (_sortAscending) {
                  return a.model!.compareTo(b.model!);
                } else {
                  return b.model!.compareTo(a.model!);
                }
              });
            });
          },
        ),
        DataColumn(
          label: Text(S.of(context).expires),
          onSort: (columnIndex, ascending) {
            setState(() {
              _sortColumnIndex = columnIndex;
              _sortAscending = ascending;
              widget.vehicles.sort((a, b) {
                if (_sortAscending) {
                  return a.expries!.compareTo(b.expries!);
                } else {
                  return b.expries!.compareTo(a.expries!);
                }
              });
            });
          },
        ),
        DataColumn(
          label: Text(S.of(context).color),
        ),
        const DataColumn(
          label: Text(''),
        ),
      ],
      source: TableSource(widget.vehicles, context, widget.provider,
          _showDialogConfirm, _showDialogRemove),
    );
  }

  _showDialogConfirm(LogsTable vehicle) {
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
              '${S.of(context).accpeptRegister}\n${S.of(context).sendSMSto}${vehicle.name}',
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
                    widget.provider.accpectRequest(vehicle.id.toString());
                    widget.provider.sendSMS(
                        vehicle.phone ?? '', S.of(context).approvedRequest);
                    Navigator.pop(context);
                    AppToast().showToast(S.of(context).sent);
                  },
                  child: Text(
                    S.of(context).sendSMS,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )),
            ],
          );
        });
  }

  _showDialogRemove(LogsTable vehicle) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                S.of(context).sendNotification.toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            content: Text(
              '${S.of(context).cancelRegister}\n${S.of(context).sendSMSto}${vehicle.name}',
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
                    widget.provider.removeRequest(vehicle.id.toString());
                    widget.provider.sendSMS(
                        vehicle.phone ?? '', S.of(context).cancleRequest);
                    Navigator.pop(context);
                    AppToast().showToast(S.of(context).sent);
                  },
                  child: Text(
                    S.of(context).sendSMS,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )),
            ],
          );
        });
  }
}

class TableSource extends DataTableSource {
  final List<LogsTable> vehicles;
  final BuildContext context;
  final RequestProvider provider;
  final Function onAccecpt;
  final Function onRemove;
  TableSource(this.vehicles, this.context, this.provider, this.onAccecpt,
      this.onRemove);

  @override
  DataRow? getRow(int index) {
    if (index >= vehicles.length) {
      return null;
    }
    final log = vehicles[index];
    return DataRow(cells: [
      DataCell(Text('${index + 1}')),
      DataCell(Text(log.name ?? '')),
      DataCell(Text(log.phone ?? '')),
      DataCell(Text(log.vehicleID ?? '')),
      DataCell(Text(log.model ?? '')),
      DataCell(
        Text(
          log.expries ?? '',
        ),
      ),
      DataCell(Text(
        log.color ?? '',
        style: TextStyle(color: Color(int.parse(log.color ?? '0xffffff'))),
      )),
      DataCell(Row(
        children: [
          IconButton(
            onPressed: () {
              onAccecpt(vehicles[index]);
            },
            icon: const Icon(
              Icons.done,
              color: AppColor.successColor,
            ),
          ),
          IconButton(
            onPressed: () {
              onRemove(vehicles[index]);
            },
            icon: const Icon(
              Icons.delete,
              color: AppColor.errorColor,
            ),
          )
        ],
      )),
    ]);
  }

  @override
  int get rowCount => vehicles.length;
  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
