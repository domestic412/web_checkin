import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:web_checkin/assets/global.dart';
import 'package:http/http.dart' as http;

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
      var url = '$SERVER/CheckIn/TotalNotCheckedIn';
      final response = await http.get(Uri.parse(url), headers: {
        "Content-Type": "application/json",
      });
      switch (response.statusCode) {
        case 200:
          // EasyLoading.dismiss();
          var body = response.body;
          print('Get all id');
          List dataList = json.decode(body);
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
