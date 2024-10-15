import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_checkin/appbar.dart';
import 'package:web_checkin/assets/color_style.dart';
import 'package:web_checkin/controller/controller_checkin.dart';
import 'package:web_checkin/model/model_getData.dart';

import 'data_checkin_list.dart';

class CheckInPage extends StatefulWidget {
  const CheckInPage({super.key});

  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  DataTableCheckIn _dataCheckin = DataTableCheckIn(data: [], onRefresh: () {});
  DataTableCheckIn _list_filter = DataTableCheckIn(data: [], onRefresh: () {});

  TextEditingController _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    GetData().fetchDataList().then((data) {
      setState(() {
        _dataCheckin = DataTableCheckIn(data: data, onRefresh: refresh);
        _list_filter = _dataCheckin;
      });
    });
  }

  void refresh() {
    GetData().fetchDataList().then((data) {
      setState(() {
        _dataCheckin = DataTableCheckIn(data: data, onRefresh: refresh);
        _list_filter = _dataCheckin;
      });
    });
  }

  void _filterData() {
    setState(() {
      final filterData = _dataCheckin.list_filter(_search.text);
      _list_filter = DataTableCheckIn(data: filterData, onRefresh: refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MenuWidget(),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Check In',
                  style: TextStyle(
                      fontSize: 30,
                      // fontWeight: FontWeight.bold,
                      color: haian),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                  decoration: BoxDecoration(
                    color: white,
                    border: Border.all(
                      color: blue.withOpacity(0.4),
                      width: 0.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 6),
                          color: blue.withOpacity(0.1),
                          blurRadius: 12)
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Container(
                    constraints: BoxConstraints(minWidth: 500, maxWidth: 750),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black45)),
                    child: ListTile(
                      dense: true,
                      title: TextField(
                        controller: _search,
                        decoration: const InputDecoration(
                            hintText: 'Search',
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.all(0)),
                        onChanged: (value) {
                          _filterData();
                        },
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () {
                          _search.clear();
                          _filterData();
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1200,
                  decoration: BoxDecoration(
                    color: white,
                    border: Border.all(color: blue.withOpacity(.4), width: .5),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 6),
                          color: blue.withOpacity(.1),
                          blurRadius: 12)
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: PaginatedDataTable(
                      showCheckboxColumn: false,
                      sortColumnIndex: 0,
                      columnSpacing: 16,
                      columns: const [
                        DataColumn(label: Text('Seq')),
                        DataColumn(label: Text('Code')),
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Company')),
                        DataColumn(label: Text('Position')),
                        DataColumn(label: Text('Table')),
                        DataColumn(label: Text('Check In')),
                      ],
                      source: _list_filter),
                ),
                Obx(
                  () => Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SelectableText(
                          '${checkinController.listError}',
                          style: TextStyle(fontSize: 15, color: red),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: InkWell(
                            onTap: () {
                              checkinController.listError.clear();
                            },
                            child: Text(
                              'Clear',
                              style: TextStyle(color: haian),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
