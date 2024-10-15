import 'package:flutter/material.dart';
import 'package:web_checkin/controller/controller_checkin.dart';
import 'package:web_checkin/model/model_getData.dart';

import 'popup_checkin/popup_checkin.dart';

class DataTableCheckIn extends DataTableSource {
  List<GetData>? data;
  final VoidCallback onRefresh;

  DataTableCheckIn({this.data, required this.onRefresh});

  List<GetData> list_filter(String query) {
    return data!
        .where((item) =>
            (item.code?.toUpperCase().contains(query.toUpperCase()) ?? false) ||
            (item.name?.toUpperCase().contains(query.toUpperCase()) ?? false) ||
            (item.guest?.toUpperCase().contains(query.toUpperCase()) ??
                false) ||
            (item.position?.toUpperCase().contains(query.toUpperCase()) ??
                false))
        .toList();
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

    return DataRow(onSelectChanged: (value) {}, cells: [
      DataCell(
        SelectableText((index + 1).toString()),
      ),
      DataCell(
        SelectableText(rowData.code!),
      ),
      DataCell(
        SelectableText(rowData.name!),
      ),
      DataCell(
        SelectableText(rowData.guest!),
      ),
      DataCell(
        SelectableText(rowData.position!),
      ),
      DataCell(
        SelectableText(rowData.tableNumber.toString()),
      ),
      DataCell(
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
          ),
          onPressed: () {
            checkinController.updateDataCheckin(
              code: data![index].code!,
              name: data![index].name!,
              guest: data![index].guest!,
              position: data![index].position!,
              numOfParticipants: data![index].numOfParticipants!,
              tableNumber: data![index].tableNumber!,
              isChecked: data![index].isChecked!,
            );
            DialogHelper.showMyDialog(onRefresh);
          },
          child: Text('Check In'),
        ),
      ),
    ]);
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
