import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:web_checkin/assets/color_style.dart';
import 'package:web_checkin/controller/controller_checkin.dart';
import 'package:web_checkin/main.dart';
import 'package:web_checkin/model/create_user.dart';
import 'package:web_checkin/model/send_attendance.dart';

class DialogHelper {
  static void showMyDialog(VoidCallback refreshCallBack) {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (BuildContext context) {
        checkinController.add.value = false;
        //textfield create new user
        TextEditingController nameUser = TextEditingController();
        String? text_check;
        String? text_ok;
        Color? color_check;
        Color? color_ok;
        if (checkinController.isChecked.value == false) {
          text_check = 'Checkin';
          color_check = green;
          text_ok = 'Cancel';
          color_ok = red;
        } else {
          text_check = 'Uncheck';
          color_check = red;
          text_ok = 'OK';
          color_ok = green;
        }
        return AlertDialog(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Check In',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: FittedBox(
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                    child: Center(
                      child: SelectableText.rich(
                        TextSpan(
                          text: 'Code:   ',
                          style: style_label,
                          children: <TextSpan>[
                            TextSpan(
                              text: checkinController.code.value,
                              style: style_content2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Name:   ',
                          style: style_label,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 30),
                        width: 300,
                        decoration: BoxDecoration(
                          border: Border.all(color: blue.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          controller: checkinController.name.value,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 10),
                            // isDense: true
                          ),
                        ),
                      ),
                      Text('Table:   '),
                      Container(
                        width: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: blue.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          controller: checkinController.tableNumber.value,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ], // Only numbers can be entered
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 10),
                            // isDense: true
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 40,
                        child: Center(
                          child: SelectableText.rich(
                            TextSpan(
                              text: 'Guest:   ',
                              style: style_label,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 30),
                        width: 430,
                        decoration: BoxDecoration(
                          border: Border.all(color: blue.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          controller: checkinController.guest.value,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 10),
                            // isDense: true
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 40,
                        child: Center(
                          child: SelectableText.rich(
                            TextSpan(
                              text: 'Position:   ',
                              style: style_label,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 30),
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: blue.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          controller: checkinController.position.value,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 10),
                            // isDense: true
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  checkinController.add.value == false
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: orange,
                          ),
                          onPressed: () {
                            checkinController.add.value = true;
                          },
                          child: Icon(Icons.add))
                      : SizedBox.shrink(),
                  checkinController.add.value == true
                      ? Column(
                          children: [
                            Row(
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'Name:   ',
                                    style: style_label,
                                  ),
                                ),
                                Container(
                                  width: 300,
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: blue.withOpacity(0.5)),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: TextField(
                                    controller: nameUser,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(left: 10),
                                      // isDense: true
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: red,
                                    ),
                                    onPressed: () {
                                      checkinController.add.value = false;
                                    },
                                    child: Icon(Icons.remove))
                              ],
                            ),
                          ],
                        )
                      : SizedBox(),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: color_check,
                          ),
                          onPressed: () {
                            if (checkinController.add.value == true &&
                                nameUser.text == '') {
                            } else {
                              fetchDataList(
                                  code: checkinController.code.value,
                                  name: checkinController.name.value.text,
                                  guest: checkinController.guest.value.text,
                                  abbreviatedGuest: checkinController
                                      .abbreviatedGuest.value.text,
                                  position:
                                      checkinController.position.value.text,
                                  tableNumber: int.parse(
                                      checkinController.tableNumber.value.text),
                                  isChecked:
                                      !(checkinController.isChecked.value),
                                  refresh: refreshCallBack);
                              checkinController.add.value == true
                                  ? sendCreateCheckin(
                                      code: checkinController.code.value,
                                      name: nameUser.text,
                                      tableNumber: int.parse(checkinController
                                          .tableNumber.value.text))
                                  : null;
                              Navigator.of(context).pop();
                            }
                          },
                          child: Container(
                            width: 400,
                            height: 40,
                            child: Center(
                              child: Text(
                                text_check!,
                                style: TextStyle(color: white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: color_ok,
                          ),
                          onPressed: () {
                            if (checkinController.isChecked.value == true) {
                              fetchDataList(
                                  code: checkinController.code.value,
                                  name: checkinController.name.value.text,
                                  guest: checkinController.guest.value.text,
                                  abbreviatedGuest: checkinController
                                      .abbreviatedGuest.value.text,
                                  position:
                                      checkinController.position.value.text,
                                  tableNumber: int.parse(
                                      checkinController.tableNumber.value.text),
                                  isChecked: checkinController.isChecked.value,
                                  refresh: refreshCallBack);
                              if (checkinController.add.value == true) {
                                sendCreateCheckin(
                                    code: checkinController.code.value,
                                    name: nameUser.text,
                                    tableNumber: int.parse(checkinController
                                        .tableNumber.value.text));
                              }
                            }
                            Navigator.of(context).pop();
                            // checkinController.isChecked.value == true ? {
                            //   fetchDataList(
                            //       code: checkinController.code.value,
                            //       name: checkinController.name.value.text,
                            //       tableNumber: int.parse(
                            //           checkinController.tableNumber.value.text),
                            //       isChecked:
                            //           !(checkinController.isChecked.value),
                            //       refresh: refreshCallBack);
                            //   checkinController.add.value == true
                            //       ? sendCreateCheckin(
                            //           code: checkinController.code.value,
                            //           name: nameUser.text,
                            //           tableNumber: int.parse(checkinController
                            //               .tableNumber.value.text))
                            // } :
                            // Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 40,
                            child: Center(
                              child: Text(
                                text_ok!,
                                style: TextStyle(color: white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
