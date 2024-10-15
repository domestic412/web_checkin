import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:web_checkin/assets/global.dart';
import 'package:web_checkin/controller/controller_checkin.dart';

Future<void> sendCreateCheckin(
    {required String code,
    required String name,
    required int numOfParticipants}) async {
  try {
    var url = '$SERVER/CheckIn/CreateUser';
    Map<String, dynamic> data = {
      "code": code,
      "name": name,
      "numOfParticipants": numOfParticipants
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
        print('Create Checkin done');
        print(checkinController.listError);
      default:
        checkinController.listError.add(name);
        EasyLoading.showError('${response.reasonPhrase}');
        throw Exception('Error: Create ${response.reasonPhrase}');
    }
  } on Exception catch (e) {
    EasyLoading.showError('$e');
    checkinController.listError.add(name);
    throw Exception('Error: $e Create Checkin');
  }
}
