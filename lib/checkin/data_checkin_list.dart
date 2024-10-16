import 'package:flutter/material.dart';
import 'package:web_checkin/controller/controller_checkin.dart';
import 'package:web_checkin/model/model_getData.dart';
import 'package:web_checkin/model/send_attendance.dart';

import 'popup_checkin/popup_checkin.dart';

class DataTableCheckIn extends DataTableSource {
  List<GetData>? data;
  final VoidCallback onRefresh;

  DataTableCheckIn({this.data, required this.onRefresh});

  List<GetData> list_filter(String query) {
    return data!
        .where(
          (item) =>
              (item.code
                      ?.toUpperCase()
                      .contains(query.toUpperCase()) ??
                  false) ||
              (item.name?.toUpperCase().contains(query.toUpperCase()) ??
                  false) ||
              (item.guest?.toUpperCase().contains(query.toUpperCase()) ??
                  false) ||
              (item.position?.toUpperCase().contains(query.toUpperCase()) ??
                  false) ||
              (item.extend?.toUpperCase().contains(query.toUpperCase()) ??
                  false),
        )
        .toList();
  }

  List<GetData> filter_checked(bool query) {
    return data!.where((item) => (item.isChecked == query)).toList();
  }

  List<GetData> filter_extend() {
    return data!.where((item) => (item.extend!.length > 2)).toList();
  }

  @override
  DataRow? getRow(int index) {
    if (index >= data!.length) {
      return null;
    }
    final rowData = data![index];
    rowData.code ??= '';
    rowData.name ??= '';
    rowData.guest ??= '';
    rowData.position ??= '';
    rowData.numOfParticipants ??= 1;
    rowData.tableNumber ??= 0;
    rowData.isChecked ??= false;
    rowData.extend ??= '';
    return DataRow(
      onSelectChanged: (value) {},
      cells: [
        DataCell(
          Container(
            width: 50,
            child: SelectableText((index + 1).toString()),
          ),
        ),
        DataCell(
          Container(
            width: 200,
            child: SelectableText(rowData.name!),
          ),
        ),
        DataCell(
          Container(
            width: 400,
            child: SelectableText(rowData.guest!),
          ),
        ),
        DataCell(
          Container(
            width: 80,
            child: SelectableText(rowData.position!),
          ),
        ),
        DataCell(
          Container(
            width: 50,
            child: SelectableText(rowData.tableNumber.toString()),
          ),
        ),
        DataCell(
          rowData.isChecked == false
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                  onPressed: () {
                    fetchDataList(
                        code: data![index].code!,
                        name: data![index].name!,
                        tableNumber: data![index].tableNumber!,
                        isChecked: true,
                        refresh: onRefresh);
                  },
                  child: Text('Checkin'),
                )
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {},
                  child: Text('Checkin'),
                ),
        ),
        DataCell(InkWell(
            onTap: () {
              checkinController.updateDataCheckin(
                code: data![index].code!,
                name: data![index].name!,
                guest: data![index].guest!,
                position: data![index].position!,
                tableNumber: data![index].tableNumber!.toString(),
                isChecked: data![index].isChecked!,
              );
              DialogHelper.showMyDialog(onRefresh);
            },
            child: Icon(
              Icons.settings,
              size: 15,
            ))),
        DataCell(
          Container(
            width: 200,
            child: SelectableText(rowData.extend!),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => data!.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
