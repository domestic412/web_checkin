import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_checkin/appbar.dart';
import 'package:web_checkin/assets/color_style.dart';
import 'package:web_checkin/assets/variable.dart';
import 'package:web_checkin/controller/controller_checkin.dart';
import 'package:web_checkin/model/model_getData.dart';

import 'data_checkin_list.dart';
import 'export/button_export.dart';

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
        final filterData = _dataCheckin.list_filter('');
        _list_filter = DataTableCheckIn(data: filterData, onRefresh: refresh);
      });
    });
    myFocusNode = FocusNode();
  }

  void refresh() {
    GetData().fetchDataList().then((data) {
      setState(() {
        _search.clear();
        _dataCheckin = DataTableCheckIn(data: data, onRefresh: refresh);
        final filterData = _dataCheckin.list_filter(_search.text);
        _list_filter = DataTableCheckIn(data: filterData, onRefresh: refresh);
      });
    });
  }

  void _filterData() {
    setState(() {
      final filterData = _dataCheckin.list_filter(_search.text);
      _list_filter = DataTableCheckIn(data: filterData, onRefresh: refresh);
    });
  }

  bool check = false;
  bool check_extend = false;

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.sizeOf(context).width,
            child: Stack(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MenuWidget(refresh),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 10),
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
                          constraints:
                              BoxConstraints(minWidth: 500, maxWidth: 750),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.black45)),
                          child: ListTile(
                            dense: true,
                            title: TextField(
                              controller: _search,
                              autofocus: true,
                              focusNode: myFocusNode,
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
                      ExportButton(),
                    ],
                  ),
                  Container(
                    width: 1200,
                    decoration: BoxDecoration(
                      color: white,
                      border:
                          Border.all(color: blue.withOpacity(.4), width: .5),
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
                        columns: <DataColumn>[
                          const DataColumn(
                            label: SizedBox(width: 50, child: Text('Seq')),
                          ),
                          const DataColumn(
                            label: Text('Name'),
                          ),
                          const DataColumn(
                            label: Text('Company'),
                          ),
                          const DataColumn(
                            label: Text('Position'),
                          ),
                          const DataColumn(
                            label: Text('Table'),
                          ),
                          DataColumn(
                            label: InkWell(
                              onTap: () {
                                setState(() {
                                  check = !check;
                                  _list_filter = DataTableCheckIn(
                                      data: _dataCheckin.filter_checked(check),
                                      onRefresh: refresh);
                                });
                              },
                              child: Text('Checkin'),
                            ),
                          ),
                          const DataColumn(
                            label: SizedBox(width: 30, child: Text('Fix')),
                          ),
                          DataColumn(
                            label: InkWell(
                              onTap: () {
                                setState(() {
                                  check_extend = !check_extend;
                                  _list_filter = DataTableCheckIn(
                                      data: _dataCheckin.filter_extend(),
                                      onRefresh: refresh);
                                });
                              },
                              child: Text('Extend'),
                            ),
                          ),
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
              Obx(
                () => Container(
                  width: MediaQuery.sizeOf(context).width,
                  margin: EdgeInsets.only(top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 60,
                        // padding: EdgeInsets.symmetric(horizontal: 5),
                        height: 40,
                        color: green,
                        child: Center(
                          child: Text(
                            checkinController.numChecked.value.toString(),
                            style: TextStyle(color: white),
                          ),
                        ),
                      ),
                      Container(
                        width: 60,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        height: 40,
                        color: grey,
                        child: Center(
                          child: Text(
                            checkinController.numCheck.value.toString(),
                            style: TextStyle(color: white),
                          ),
                        ),
                      ),
                      Container(
                        width: 60,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        height: 40,
                        color: orange,
                        child: Center(
                          child: Text(
                            checkinController.numAll.value.toString(),
                            style: TextStyle(color: white),
                          ),
                        ),
                      ),
                      Container(
                        width: 60,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        height: 40,
                        color: red,
                        child: Center(
                          child: Text(
                            checkinController.numExt.value.toString(),
                            style: TextStyle(color: white),
                          ),
                        ),
                      ),
                      Container(
                        width: 60,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        height: 40,
                        color: haian,
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              refresh();
                            },
                            child: Text(
                              'Reload',
                              style: TextStyle(color: white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
