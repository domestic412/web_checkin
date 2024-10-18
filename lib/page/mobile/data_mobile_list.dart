import 'package:flutter/material.dart';
import 'package:web_checkin/assets/color_style.dart';
import 'package:web_checkin/model/model_getData.dart';

class DataTableMobile extends DataTableSource {
  List<GetData>? data;
  Color? color;

  DataTableMobile({this.data});

  List<GetData> list_filter(String query) {
    return data!
        .where(
          (item) =>
              (item.numOfParticipants == 1) &&
              ((item.code?.toUpperCase().contains(query.toUpperCase()) ??
                      false) ||
                  (item.name?.toUpperCase().contains(query.toUpperCase()) ??
                      false) ||
                  (item.guest?.toUpperCase().contains(query.toUpperCase()) ??
                      false) ||
                  (item.position?.toUpperCase().contains(query.toUpperCase()) ??
                      false) ||
                  (item.extend?.toUpperCase().contains(query.toUpperCase()) ??
                      false)),
        )
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
    return DataRow(
      onSelectChanged: (value) {},
      cells: [
        // DataCell(
        //   Container(
        //     width: 50,
        //     child: SelectableText((index + 1).toString()),
        //   ),
        // ),
        DataCell(
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    RichText(
                        text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Name: ',
                          style: TextStyle(color: black),
                        ),
                        TextSpan(
                          text: '${rowData.name!}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: black),
                        ),
                      ],
                    )),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    RichText(
                        text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Company: ',
                          style: TextStyle(color: black),
                        ),
                        TextSpan(
                          text: '${rowData.guest!}',
                          style: TextStyle(color: black),
                        ),
                      ],
                    )),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    RichText(
                        text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Table: ',
                          style: TextStyle(color: black),
                        ),
                        TextSpan(
                          text: '${rowData.tableNumber!}',
                          style: TextStyle(
                              fontSize: 20,
                              color: orange,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                  ],
                ),
                // SizedBox(
                //   height: 5,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     rowData.isChecked == false
                //         ? ElevatedButton(
                //             style: ElevatedButton.styleFrom(
                //               backgroundColor: Colors.grey,
                //             ),
                //             onPressed: () {},
                //             child: Text('Checkin'),
                //           )
                //         : ElevatedButton(
                //             style: ElevatedButton.styleFrom(
                //               backgroundColor: Colors.green,
                //             ),
                //             onPressed: () {},
                //             child: Text('Checkin'),
                //           ),
                //   ],
                // ),
              ],
            ),
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
