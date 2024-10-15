import 'package:flutter/material.dart';
import 'package:get/get.dart';

final CheckinController checkinController = Get.put(CheckinController());

class CheckinController extends GetxController {
  var code = ''.obs;
  var name = TextEditingController().obs;
  var guest = ''.obs;
  var position = ''.obs;
  var numOfParticipants = 0.obs;
  var tableNumber = 0.obs;
  var isChecked = false.obs;

  var add = false.obs;
  var listError = [].obs;

  updateDataCheckin(
      {required String code,
      required String name,
      required String guest,
      required String position,
      required int numOfParticipants,
      required int tableNumber,
      required bool isChecked}) {
    this.code.value = code;
    this.name.value.text = name;
    this.guest.value = guest;
    this.position.value = position;
    this.numOfParticipants.value = numOfParticipants;
    this.tableNumber.value = tableNumber;
    this.isChecked.value = isChecked;
  }
}
