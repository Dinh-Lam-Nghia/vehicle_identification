import 'package:flutter/material.dart';
import 'package:vehicle_identification/app/admin/layout/drawer.dart';
import 'package:vehicle_identification/app/admin/layout/nav_bar.dart';

import 'package:vehicle_identification/app/utils/app_color.dart';
import 'package:vehicle_identification/generated/l10n.dart';
import 'package:vehicle_identification/widget/app_input.dart';
import 'package:vehicle_identification/widget/app_responsive.dart';

class AllVehicleScreen extends StatefulWidget {
  const AllVehicleScreen({super.key});

  @override
  State<AllVehicleScreen> createState() => _AllVehicleScreenState();
}

class _AllVehicleScreenState extends State<AllVehicleScreen> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveContainer(
      large: AllVehicle(
        isSmall: false,
      ),
      small: AllVehicle(
        isSmall: true,
      ),
      medium: AllVehicle(
        isSmall: false,
      ),
    );
  }
}

class AllVehicle extends StatefulWidget {
  const AllVehicle({super.key, required this.isSmall});
  final bool isSmall;

  @override
  State<AllVehicle> createState() => _AllVehicleState();
}

class _AllVehicleState extends State<AllVehicle> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    TextEditingController _controller = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      resizeToAvoidBottomInset: false,
      drawer: const DrawerApp(),
      appBar: NavBar(
        title: S.of(context).allVehicle,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: widget.isSmall
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppInput(
                      controller: _controller,
                      labelText: S.of(context).search,
                      width: widget.isSmall ? width * 0.8 : width * 0.3),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.download,
                        color: AppColor.primary,
                      ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const DataTableExample()
            ],
          ),
        ),
      ),
    );
  }
}

class MyDataSource extends DataTableSource {
  static const List<int> _displayIndexToRawIndex = <int>[0, 3, 4, 5, 6];

  late List<List<Comparable<Object>>> sortedData;
  void setData(List<List<Comparable<Object>>> rawData, int sortColumn,
      bool sortAscending) {
    sortedData = rawData.toList()
      ..sort((List<Comparable<Object>> a, List<Comparable<Object>> b) {
        final Comparable<Object> cellA = a[_displayIndexToRawIndex[sortColumn]];
        final Comparable<Object> cellB = b[_displayIndexToRawIndex[sortColumn]];
        return cellA.compareTo(cellB) * (sortAscending ? 1 : -1);
      });
    notifyListeners();
  }

  @override
  int get rowCount => sortedData.length;

  static DataCell cellFor(Object data) {
    String value;
    if (data is DateTime) {
      value =
          '${data.year}-${data.month.toString().padLeft(2, '0')}-${data.day.toString().padLeft(2, '0')}';
    } else {
      value = data.toString();
    }
    return DataCell(InkWell(onTap: () {}, child: Text(value)));
  }

  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(
      index: sortedData[index][0] as int,
      cells: <DataCell>[
        cellFor(
          'S${sortedData[index][1]}E${sortedData[index][2].toString().padLeft(2, '0')}',
        ),
        cellFor(sortedData[index][3].toString()),
        cellFor(sortedData[index][4].toString()),
        cellFor(sortedData[index][5].toString()),
        cellFor(sortedData[index][6].toString()),
        cellFor(sortedData[index][7].toString()),
        cellFor(sortedData[index][8].toString()),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => 0;
}

class DataTableExample extends StatefulWidget {
  const DataTableExample({super.key});

  @override
  State<DataTableExample> createState() => _DataTableExampleState();
}

class _DataTableExampleState extends State<DataTableExample> {
  final MyDataSource dataSource = MyDataSource()..setData(episodes, 0, true);

  int _columnIndex = 0;
  bool _columnAscending = true;

  void _sort(int columnIndex, bool ascending) {
    setState(() {
      _columnIndex = columnIndex;
      _columnAscending = ascending;
      dataSource.setData(episodes, _columnIndex, _columnAscending);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      sortColumnIndex: _columnIndex,
      sortAscending: _columnAscending,
      columns: <DataColumn>[
        DataColumn(
          label: Text(S.of(context).no),
          onSort: _sort,
        ),
        DataColumn(
          label: Text(S.of(context).fullName),
          onSort: _sort,
        ),
        DataColumn(
          label: Text(S.of(context).phone),
          onSort: _sort,
        ),
        DataColumn(
          label: Text(S.of(context).licensePlate),
          onSort: _sort,
        ),
        DataColumn(
          label: Text(S.of(context).model),
          onSort: _sort,
        ),
        DataColumn(
          label: Text(S.of(context).expires),
          onSort: _sort,
        ),
        DataColumn(
          label: Text(S.of(context).status),
          onSort: _sort,
        ),
      ],
      source: dataSource,
    );
  }
}

final List<List<Comparable<Object>>> episodes = <List<Comparable<Object>>>[
  <Comparable<Object>>[
    1,
    1,
    1,
    'Nguyễn Văn A',
    '0346056590',
    '30Z0779',
    'Honda',
    DateTime(2022, 5, 5),
    'Còn hạn',
  ],
  <Comparable<Object>>[
    2,
    1,
    2,
    'Nguyễn Văn B',
    '0948264927',
    '30A55577',
    'Yamaha',
    DateTime(2022, 5, 12),
    'Hết hạn',
  ],
  <Comparable<Object>>[
    3,
    1,
    3,
    'Nguyễn Văn C',
    '0821642318',
    '29N63133',
    'Kia',
    DateTime(2022, 5, 19),
    'Hết hạn',
  ],
  <Comparable<Object>>[
    4,
    1,
    4,
    'Nguyễn Văn D',
    '0973752659',
    '29LD4189',
    'BMW',
    DateTime(2022, 5, 26),
    'Còn hạn',
  ],
  <Comparable<Object>>[
    5,
    1,
    5,
    'Nguyễn Văn E',
    '0984536712',
    '68A00045',
    'Lexus',
    DateTime(2022, 6, 2),
    'Còn hạn',
  ],
  <Comparable<Object>>[
    6,
    1,
    6,
    'Trần Văn A',
    '0868347502',
    '68C0963',
    'Mazda',
    DateTime(2022, 6, 9),
    'Hết hạn',
  ],
  <Comparable<Object>>[
    7,
    1,
    7,
    'Trần Văn B',
    '0964869345',
    '99A33333',
    'Land Rover',
    DateTime(2022, 6, 16),
    'Hết hạn',
  ],
  <Comparable<Object>>[
    8,
    1,
    8,
    'Trần Văn C',
    '0985634564',
    '43A27208',
    'Hyundai',
    DateTime(2022, 6, 23),
    'Hết hạn',
  ],
  <Comparable<Object>>[
    9,
    1,
    9,
    'Trần Văn D',
    '0978945673',
    '37A99999',
    'Toyota',
    DateTime(2022, 6, 30),
    'Còn hạn',
  ],
  <Comparable<Object>>[
    10,
    2,
    10,
    'Trần Văn E',
    '0971846356',
    '43A99999',
    'BMW',
    DateTime(2022, 7, 7),
    'Còn hạn',
  ],
  <Comparable<Object>>[
    11,
    2,
    1,
    'Phan Đình A',
    '0868234065',
    '34A34567',
    'Honda',
    DateTime(2023, 6, 15),
    'Còn hạn',
  ],
  <Comparable<Object>>[
    12,
    2,
    2,
    'Phan Đình B',
    '0968125374',
    '77K134049',
    'Yamaha',
    DateTime(2023, 6, 22),
    'Hết hạn',
  ],
  <Comparable<Object>>[
    13,
    2,
    3,
    'Phan Đình C',
    '0982367932',
    '77H58836',
    'Kia',
    DateTime(2023, 6, 29),
    'Hết hạn',
  ],
  <Comparable<Object>>[
    14,
    2,
    4,
    'Phan Đình D',
    '0988642318',
    '77K177777',
    'BMW',
    DateTime(2023, 7, 6),
    'Còn hạn',
  ],
  <Comparable<Object>>[
    15,
    2,
    5,
    'Phan Đình E',
    '0782138346',
    '89K98989',
    'Lexus',
    DateTime(2023, 7, 13),
    'Hết hạn',
  ],
  <Comparable<Object>>[
    16,
    2,
    6,
    'Thái Văn A',
    '0989831246',
    '30F22222',
    'Mazda',
    DateTime(2023, 7, 20),
    'Còn hạn',
  ],
  <Comparable<Object>>[
    17,
    2,
    7,
    'Thái Văn B',
    '0986243054',
    '30E15349',
    'Land Rover',
    DateTime(2023, 7, 22),
    'Còn hạn',
  ],
  <Comparable<Object>>[
    18,
    2,
    8,
    'Thái Văn C',
    '0987654321',
    '51A01088',
    'Hyundai',
    DateTime(2023, 7, 27),
    'Hết hạn',
  ],
  <Comparable<Object>>[
    19,
    2,
    9,
    'Thái Văn D',
    '0984591236',
    '22L82881',
    'Toyota',
    DateTime(2023, 8, 3),
    'Còn hạn',
  ],
  <Comparable<Object>>[
    20,
    2,
    10,
    'Thái Văn E',
    '0847688347',
    '29C199999',
    'Honda',
    DateTime(2023, 8, 10),
    'Hết hạn',
  ],
];
