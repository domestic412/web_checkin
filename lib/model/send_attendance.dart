import 'dart:convert';
import 'dart:html';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:web_checkin/assets/global.dart';
import 'package:web_checkin/assets/variable.dart';
import 'package:web_checkin/controller/controller_checkin.dart';

Future<void> fetchDataList(
    {required String code,
    required String name,
    required String guest,
    required String abbreviatedGuest,
    required String position,
    required int tableNumber,
    required bool isChecked,
    required VoidCallback refresh}) async {
  try {
    // EasyLoading.show(
    //   status: 'Loading...',
    //   maskType: EasyLoadingMaskType.black,
    //   dismissOnTap: true,
    // );
    var url = '$SERVER/CheckIn/Attendance';
    Map<String, dynamic> data = {
      "code": code,
      "name": name,
      "guest": guest,
      "abbreviatedGuest": abbreviatedGuest,
      "position": position,
      "tableNumber": tableNumber,
      "isChecked": isChecked
    };
    var body = json.encode(data);
    final response = await http.post(Uri.parse(url),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Methods": "POST",
          "Content-Type": "application/json",
        },
        body: body);
    switch (response.statusCode) {
      case 200:
        EasyLoading.showSuccess('', duration: Duration(milliseconds: 200));
        print('Check-in done');
        print(checkinController.listError);
        refresh();
        myFocusNode.requestFocus();
      default:
        checkinController.listError.add(code);
        EasyLoading.showError('${response.reasonPhrase}');
        throw Exception('Error: GetData ${response.reasonPhrase}');
    }
  } on Exception catch (e) {
    EasyLoading.showError('$e');
    checkinController.listError.add(code);
    throw Exception('Error: $e Send Checkin');
  }
}
