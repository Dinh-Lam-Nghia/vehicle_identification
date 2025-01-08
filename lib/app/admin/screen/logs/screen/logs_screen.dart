import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_identification/app/admin/layout/drawer.dart';
import 'package:vehicle_identification/app/admin/layout/nav_bar.dart';
import 'package:vehicle_identification/app/admin/model/log_table.dart';
import 'package:vehicle_identification/app/admin/screen/logs/provider/log_provider.dart';
import 'package:vehicle_identification/app/utils/app_color.dart';
import 'package:vehicle_identification/generated/l10n.dart';
import 'package:vehicle_identification/widget/app_input.dart';
import 'package:vehicle_identification/widget/app_responsive.dart';

class LogsScreen extends StatefulWidget {
  const LogsScreen({super.key});

  @override
  State<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  final LogProvider _provider = LogProvider();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ResponsiveContainer(
      large: Logs(
        isSmall: false,
        provider: _provider,
        width: width,
      ),
      small: Logs(
        isSmall: true,
        provider: _provider,
        width: width,
      ),
      medium: Logs(
        isSmall: false,
        provider: _provider,
        width: width,
      ),
    );
  }
}

class Logs extends StatefulWidget {
  const Logs(
      {super.key,
      required this.isSmall,
      required this.provider,
      required this.width});
  final bool isSmall;
  final LogProvider provider;
  final double width;
  @override
  State<Logs> createState() => _LogsState();
}

class _LogsState extends State<Logs> {
  @override
  void initState() {
    widget.provider.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LogProvider>(
      create: ((context) => widget.provider),
      builder: (context, child) {
        return Consumer<LogProvider>(builder: (context, p, widgets) {
          return Scaffold(
            backgroundColor: Colors.grey.shade100,
            resizeToAvoidBottomInset: false,
            drawer: const DrawerApp(),
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight), // Chiều cao AppBar chuẩn
              child: InkWell(
                onTap: () {
                  widget.provider.init();
                },
                child: NavBar(
                  title: S.of(context).logs,
                ),
              ),
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
                        width: widget.width * 0.85,
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
                        width: widget.width * 0.85,
                        child: LogTableWidget(
                          logs: p.logsTable,
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

class LogTableWidget extends StatefulWidget {
  const LogTableWidget({super.key, required this.logs});
  final List<LogsTable> logs;

  @override
  State<LogTableWidget> createState() => _LogTableWidgetState();
}

class _LogTableWidgetState extends State<LogTableWidget> {
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
              widget.logs.sort((a, b) {
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
              widget.logs.sort((a, b) {
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
              widget.logs.sort((a, b) {
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
              widget.logs.sort((a, b) {
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
          label: Text(S.of(context).time),
          onSort: (columnIndex, ascending) {
            setState(() {
              _sortColumnIndex = columnIndex;
              _sortAscending = ascending;
              widget.logs.sort((a, b) {
                if (_sortAscending) {
                  return a.time!.compareTo(b.time!);
                } else {
                  return b.time!.compareTo(a.time!);
                }
              });
            });
          },
        ),
        DataColumn(
          label: Text(S.of(context).status),
          onSort: (columnIndex, ascending) {
            setState(() {
              _sortColumnIndex = columnIndex;
              _sortAscending = ascending;
              widget.logs.sort((a, b) {
                if (_sortAscending) {
                  return a.time!.compareTo(b.time!);
                } else {
                  return b.time!.compareTo(a.time!);
                }
              });
            });
          },
        ),
      ],
      source: UserDataTableSource(widget.logs, context),
    );
  }
}

class UserDataTableSource extends DataTableSource {
  final List<LogsTable> logs;
  final BuildContext context;
  UserDataTableSource(this.logs, this.context);

  @override
  DataRow? getRow(int index) {
    if (index >= logs.length) {
      return null;
    }
    final log = logs[index];
    return DataRow(cells: [
      DataCell(Text('${index + 1}')),
      DataCell(Text(log.name ?? '')),
      DataCell(Text(log.phone ?? '')),
      DataCell(Text(log.vehicleID ?? '')),
      DataCell(Text(log.model ?? '')),
      DataCell(Text(log.time ?? '')),
      DataCell(Text(
          log.status == 0 ? S.of(context).statusOut : S.of(context).statusIn)),
    ]);
  }

  @override
  int get rowCount => logs.length;
  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}
