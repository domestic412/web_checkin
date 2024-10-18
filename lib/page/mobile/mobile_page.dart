import 'package:flutter/material.dart';
import 'package:web_checkin/appbar.dart';
import 'package:web_checkin/assets/color_style.dart';
import 'package:web_checkin/model/model_getData.dart';

import 'data_mobile_list.dart';

class MobilePage extends StatefulWidget {
  const MobilePage({super.key});

  @override
  State<MobilePage> createState() => _MobilePageState();
}

class _MobilePageState extends State<MobilePage> {
  DataTableMobile _dataCheckin = DataTableMobile(data: []);
  DataTableMobile _list_filter = DataTableMobile(data: []);

  TextEditingController _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    GetData().fetchDataList().then((data) {
      setState(() {
        _dataCheckin = DataTableMobile(data: data);
        final filterData = _dataCheckin.list_filter('');
        _list_filter = DataTableMobile(data: filterData);
      });
    });
  }

  void refresh() {
    GetData().fetchDataList().then((data) {
      setState(() {
        _dataCheckin = DataTableMobile(data: data);
        final filterData = _dataCheckin.list_filter(_search.text);
        _list_filter = DataTableMobile(data: filterData);
      });
    });
  }

  void _filterData() {
    setState(() {
      final filterData = _dataCheckin.list_filter(_search.text);
      _list_filter = DataTableMobile(data: filterData);
    });
  }

  bool check = false;
  bool check_extend = false;

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
                    Expanded(
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                              BoxConstraints(minWidth: 200, maxWidth: 300),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.black45)),
                          child: ListTile(
                            dense: true,
                            title: TextField(
                              controller: _search,
                              autofocus: true,
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
                    ),
                  ],
                ),
                Container(
                  // width: 1200,
                  margin: EdgeInsets.symmetric(horizontal: 10),
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
                      columnSpacing: 0,
                      dataRowMaxHeight: 110,
                      columns: const <DataColumn>[
                        // DataColumn(
                        //   label: SizedBox(width: 50, child: Text('Seq')),
                        // ),
                        DataColumn(
                          label: Expanded(child: Text('Information')),
                        ),
                      ],
                      source: _list_filter),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: haian,
        child: Icon(Icons.replay_outlined),
        onPressed: () {
          refresh();
        },
      ),
    );
  }
}
