import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        int numOfParticipants = 1;
        checkinController.add.value = false;
        TextEditingController nameUser = TextEditingController();
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
                        width: 300,
                        decoration: BoxDecoration(
                          border: Border.all(color: blue.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          controller: checkinController.name.value,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 10),
                            // isDense: true
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Table:   ',
                          style: style_label,
                          children: <TextSpan>[
                            TextSpan(
                              text: checkinController.tableNumber.value
                                  .toString(),
                              style: style_content,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 40,
                    child: Center(
                      child: SelectableText.rich(
                        TextSpan(
                          text: 'Guest:   ',
                          style: style_label,
                          children: <TextSpan>[
                            TextSpan(
                              text: checkinController.guest.value,
                              style: style_content2,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 40,
                    child: Center(
                      child: SelectableText.rich(
                        TextSpan(
                          text: 'Position:   ',
                          style: style_label,
                          children: <TextSpan>[
                            TextSpan(
                              text: checkinController.position.value,
                              style: style_content2,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  checkinController.add.value == false
                      ? ElevatedButton(
                          onPressed: () {
                            numOfParticipants = 2;
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
                                    decoration: InputDecoration(
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
                                      numOfParticipants = 1;
                                      checkinController.add.value = false;
                                    },
                                    child: Icon(Icons.remove))
                              ],
                            ),
                          ],
                        )
                      : SizedBox(),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: () {
                            fetchDataList(
                                code: checkinController.code.value,
                                name: checkinController.name.value.text,
                                numOfParticipants: numOfParticipants,
                                refresh: refreshCallBack);
                            checkinController.add.value == true
                                ? sendCreateCheckin(
                                    code: checkinController.code.value,
                                    name: nameUser.text,
                                    numOfParticipants: numOfParticipants)
                                : null;
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            width: 400,
                            height: 50,
                            child: Center(
                              child: Text(
                                'CHECK IN',
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
                            backgroundColor: red,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            height: 50,
                            child: Center(
                              child: Text(
                                'CANCEL',
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
