import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_checkin/model/model_getData.dart';

final CheckinController checkinController = Get.put(CheckinController());

class CheckinController extends GetxController {
  var code = ''.obs;
  var name = TextEditingController().obs;
  var guest = TextEditingController().obs;
  var abbreviatedGuest = TextEditingController().obs;
  var position = TextEditingController().obs;
  var tableNumber = TextEditingController().obs;
  var isChecked = false.obs;

  var numChecked = 0.obs;
  var numCheck = 0.obs;
  var numAll = 0.obs;
  var numExt = 0.obs;

  RxList nameTable = [
    'VIP',
    'VIP',
    'VIP',
    'VIP',
    'VIP',
    'VIP',
    'HACT HP',
    'CẢNG VỤ, NN',
    'MLO',
    'HACT HCM',
    'MLA HPH',
    'MLO',
    'ONE',
    'SML',
    'LOTUS',
    'MLA',
    'HAAL',
    'MLO',
    'HACT',
    'HACT VT,HCM',
    'HACT DN',
    'HAFC',
    'HACT HP, HCM, DN',
    'MLA HCM',
    'HAAL',
    'HAIAN',
  ].obs;
  RxList<bool> listOpen = <bool>[].obs;

  RxList<GetData> listTable1 = <GetData>[].obs;
  RxList<GetData> listTable2 = <GetData>[].obs;
  RxList<GetData> listTable3 = <GetData>[].obs;
  RxList<GetData> listTable4 = <GetData>[].obs;
  RxList<GetData> listTable5 = <GetData>[].obs;
  RxList<GetData> listTable6 = <GetData>[].obs;
  RxList<GetData> listTable7 = <GetData>[].obs;
  RxList<GetData> listTable8 = <GetData>[].obs;
  RxList<GetData> listTable9 = <GetData>[].obs;
  RxList<GetData> listTable10 = <GetData>[].obs;
  RxList<GetData> listTable11 = <GetData>[].obs;
  RxList<GetData> listTable12 = <GetData>[].obs;
  RxList<GetData> listTable15 = <GetData>[].obs;
  RxList<GetData> listTable16 = <GetData>[].obs;
  RxList<GetData> listTable17 = <GetData>[].obs;
  RxList<GetData> listTable18 = <GetData>[].obs;
  RxList<GetData> listTable19 = <GetData>[].obs;
  RxList<GetData> listTable20 = <GetData>[].obs;
  RxList<GetData> listTable21 = <GetData>[].obs;
  RxList<GetData> listTable22 = <GetData>[].obs;
  RxList<GetData> listTable23 = <GetData>[].obs;
  RxList<GetData> listTable24 = <GetData>[].obs;
  RxList<GetData> listTable25 = <GetData>[].obs;
  RxList<GetData> listTable26 = <GetData>[].obs;
  RxList<GetData> listTable27 = <GetData>[].obs;
  RxList<GetData> listTable28 = <GetData>[].obs;
  RxList<RxList<GetData>> allTable = <RxList<GetData>>[].obs;

  var add = false.obs;
  var listError = [].obs;

  updateDataCheckin(
      {required String code,
      required String name,
      required String guest,
      required String abb,
      required String position,
      required String tableNumber,
      required bool isChecked}) {
    this.code.value = code;
    this.name.value.text = name;
    this.guest.value.text = guest;
    this.abbreviatedGuest.value.text = abb;
    this.position.value.text = position;
    this.tableNumber.value.text = tableNumber;
    this.isChecked.value = isChecked;
  }
}
