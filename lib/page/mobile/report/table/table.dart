import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_checkin/assets/color_style.dart';
import 'package:web_checkin/controller/controller_checkin.dart';
import 'package:web_checkin/model/model_getData.dart';

class TableMobile extends StatefulWidget {
  @override
  State<TableMobile> createState() => _TableMobileState();
}

class _TableMobileState extends State<TableMobile> {
  Color color_checked = white;
  Color color_text = black;
  int num = 0;
  int numT = 0;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height - 90,
        margin: EdgeInsets.symmetric(),
        child: ListView.builder(
          itemCount: checkinController.allTable.length,
          itemBuilder: (context, index) {
            ///bỏ số 13 14
            if (index < 12) {
              numT = index;
            } else {
              numT = index + 2;
            }
            if (numT < 6) {
              num = 10;
            } else {
              num = 12;
            }
            return Container(
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  color: white,
                  border: Border.all(color: grey),
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                children: [
                  Container(
                    //check over
                    color: checkinController.allTable[index].length > num
                        ? red
                        : haian,
                    padding: EdgeInsets.all(5),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                contentPadding: EdgeInsets.zero,
                                titlePadding: EdgeInsets.zero,
                                title: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(1),
                                    color: checkinController
                                                .allTable[index].length >
                                            num
                                        ? red
                                        : haian,
                                  ),
                                  child: index < 12
                                      ? Text(
                                          'Table ${index + 1} (${checkinController.nameTable[index]})',
                                          style: TextStyle(
                                              fontSize: 18, color: white),
                                        )
                                      : Text(
                                          'Table ${index + 3} (${checkinController.nameTable[index]})',
                                          style: TextStyle(
                                              fontSize: 18, color: white),
                                        ),
                                ),
                                content: InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    // height: 480,
                                    width: 300,
                                    child: ListView.builder(
                                      itemCount: checkinController
                                          .allTable[index].length,
                                      itemBuilder: (context, i) {
                                        if (checkinController
                                                .allTable[index][i].isChecked ==
                                            false) {
                                          color_checked = white;
                                          color_text = black;
                                        } else {
                                          color_checked = green;
                                          color_text = white;
                                          if (checkinController
                                                  .allTable[index][i]
                                                  .numOfParticipants ==
                                              0) {
                                            color_checked = Colors.orangeAccent;
                                            color_text = white;
                                          }
                                        }
                                        return Container(
                                            // margin: EdgeInsets.only(top: 5),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5),
                                            color: color_checked,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 20),
                                                      width: 25,
                                                      alignment:
                                                          Alignment.center,
                                                      // margin:
                                                      //     EdgeInsets.symmetric(
                                                      //         horizontal: 5),
                                                      child: Text('${i + 1}.',
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color:
                                                                  color_text)),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        checkinController
                                                            .allTable[index][i]
                                                            .name!,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: color_text),
                                                      ),
                                                    ),
                                                    checkinController
                                                                .allTable[index]
                                                                    [i]
                                                                .extend!
                                                                .length >
                                                            2
                                                        ? Tooltip(
                                                            message:
                                                                '${checkinController.allTable[index][i].extend!}\n${checkinController.allTable[index][i].guest!}',
                                                            child: Icon(
                                                              Icons.check,
                                                              size: 15,
                                                              color: white,
                                                            ),
                                                          )
                                                        : const SizedBox
                                                            .shrink(),
                                                  ],
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(left: 45),
                                                  child: Text(
                                                    checkinController
                                                        .allTable[index][i]
                                                        .abbreviatedGuest!,
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: color_text),
                                                  ),
                                                )
                                              ],
                                            ));
                                      },
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: Row(
                        children: [
                          Expanded(
                              child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text:
                                    'Table ${numT + 1} (${checkinController.nameTable[index]}) ',
                                style: style_label_table,
                              ),
                              checkinController.allTable[index].length > num
                                  ? TextSpan(
                                      text:
                                          '(${checkinController.allTable[index].length})',
                                      style: style_label_table,
                                    )
                                  : TextSpan(),
                              // checkNumExt(checkinController.allTable[index]) > 0
                              //     ? TextSpan(
                              //         text:
                              //             '(${checkNumExt(checkinController.allTable[index])}/${checkinController.allTable[index].length})',
                              //         style: style_label_table,
                              //       )
                              //     : TextSpan(),
                              // checkNumExt(checkinController.allTable[index]) > 0
                              // checkinController.allTable[index].length > 12
                              //     ? TextSpan(
                              //         text:
                              //             '(${checkinController.allTable[index].length - 12})',
                              //         style: style_label_table,
                              //       )
                              //     : TextSpan()
                            ]),
                          )),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text:
                                    '${calculator(checkinController.allTable[index])} ',
                                style: style_label_table,
                              ),
                              checkNumExt(checkinController.allTable[index]) > 0
                                  ? TextSpan(
                                      text:
                                          '(${checkNumExt(checkinController.allTable[index])})',
                                      style: style_label_table,
                                    )
                                  : TextSpan(),
                              checkinController.allTable[index].length > num
                                  ? TextSpan(
                                      text: '/ $num',
                                      style: style_label_table,
                                    )
                                  : TextSpan(
                                      text:
                                          '/ ${checkinController.allTable[index].length}',
                                      style: style_label_table,
                                    ),
                            ]

                                /// bắt đầu từ index = 0 tương đương listTable1
                                // '${calculator(checkinController.allTable[index])} / ${checkOver12(checkinController.allTable[index].length)}',
                                // style: style_label_table,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  calculator(List<GetData> listTable) {
    int i = 0;
    for (var list in listTable) {
      if (list.isChecked == true) {
        i = i + 1;
      }
    }
    return i;
  }

  checkNumExt(List<GetData> listTable) {
    int i = 0;
    for (var list in listTable) {
      if (list.extend!.length > 2) {
        i = i + 1;
      }
    }
    return i;
  }

  checkOver10(int num) {
    if (num > 10) {
      return 10;
    } else {
      return num;
    }
  }

  checkOver12(int num) {
    if (num > 12) {
      return 12;
    } else {
      return num;
    }
  }
}
