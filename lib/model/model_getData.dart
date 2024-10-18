import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:web_checkin/assets/global.dart';
import 'package:http/http.dart' as http;
import 'package:web_checkin/controller/controller_checkin.dart';

class GetData {
  int? id;
  String? code;
  String? name;
  String? guest;
  String? position;
  int? numOfParticipants;
  int? tableNumber;
  bool? isChecked;
  String? updateTime;
  String? extend;

  GetData(
      {this.id,
      this.code,
      this.name,
      this.guest,
      this.position,
      this.numOfParticipants,
      this.tableNumber,
      this.isChecked,
      this.updateTime,
      this.extend});

  GetData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    guest = json['guest'];
    position = json['position'];
    numOfParticipants = json['numOfParticipants'];
    tableNumber = json['tableNumber'];
    isChecked = json['isChecked'];
    updateTime = json['updateTime'];
    extend = json['extend'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['guest'] = this.guest;
    data['position'] = this.position;
    data['numOfParticipants'] = this.numOfParticipants;
    data['tableNumber'] = this.tableNumber;
    data['isChecked'] = this.isChecked;
    data['updateTime'] = this.updateTime;
    data['extend'] = this.extend;
    return data;
  }

  Future<List<GetData>> fetchDataList() async {
    try {
      // EasyLoading.show(
      //   status: 'Loading...',
      //   maskType: EasyLoadingMaskType.black,
      //   dismissOnTap: true,
      // );
      var url = '$SERVER/CheckIn/GetAllId';
      final response = await http.get(Uri.parse(url), headers: {
        "Content-Type": "application/json",
        // "Content-Security-Policy": "upgrade-insecure-requests",
      });
      switch (response.statusCode) {
        case 200:
          // EasyLoading.dismiss();
          var body = response.body;
          print('Get all id');
          List dataList = json.decode(body);
          checkinController.numAll.value = dataList.length;
          int numCheck = 0;
          int numChecked = 0;
          int numAll = 0;
          int numExtend = 0;
          for (var list in dataList) {
            if (list['numOfParticipants'] == 1) {
              if (list['isChecked'] == true) {
                numChecked = numChecked + 1;
              } else {
                numCheck = numCheck + 1;
              }
              if (list['extend'].length > 2) {
                numExtend = numExtend + 1;
              }
              numAll = numAll + 1;
            }
          }
          checkinController.numAll.value = numAll;
          checkinController.numCheck.value = numCheck;
          checkinController.numChecked.value = numChecked;
          checkinController.numExt.value = numExtend;
          checkinController.allTable.value = [
            checkinController.listTable1,
            checkinController.listTable2,
            checkinController.listTable3,
            checkinController.listTable4,
            checkinController.listTable5,
            checkinController.listTable6,
            checkinController.listTable7,
            checkinController.listTable8,
            checkinController.listTable9,
            checkinController.listTable10,
            checkinController.listTable11,
            checkinController.listTable12,
            checkinController.listTable13,
            checkinController.listTable14,
            checkinController.listTable15,
            checkinController.listTable16,
            checkinController.listTable17,
            checkinController.listTable18,
            checkinController.listTable19,
            checkinController.listTable20,
            checkinController.listTable21,
            checkinController.listTable22,
            checkinController.listTable23,
            checkinController.listTable24,
            checkinController.listTable25,
            checkinController.listTable26
          ];
          for (int i = 0; i <= checkinController.allTable.length - 1; i++) {
            checkinController.allTable[i].value = dataList
                .map((data) => GetData.fromJson(data))
                .toList()
                .where((e) => e.tableNumber == i + 1)
                .toList();
          }
          return dataList.map((data) => GetData.fromJson(data)).toList();
        default:
          EasyLoading.dismiss();
          throw Exception('Error: GetData ${response.reasonPhrase}');
      }
    } on Exception catch (e) {
      // EasyLoading.dismiss();
      throw Exception('Error: $e GetData');
    }
  }
}
