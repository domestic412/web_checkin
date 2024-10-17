import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_checkin/assets/color_style.dart';
import 'package:web_checkin/controller/controller_checkin.dart';
import 'package:web_checkin/model/model_getData.dart';

class Table1 extends StatefulWidget {
  const Table1({super.key});

  @override
  State<Table1> createState() => _Table1State();
}

class _Table1State extends State<Table1> {
  Color color_checked = white;
  Color color_text = black;
  int num = 0;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: MediaQuery.sizeOf(context).width,
        height: 2000,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              childAspectRatio: 0.6,
              crossAxisSpacing: 40,
              mainAxisSpacing: 40),
          itemCount: checkinController.allTable.length,
          itemBuilder: (context, index) {
            if (index < 6) {
              num = 10;
            } else if (index == 7) {
              num = 13;
            } else {
              num = 12;
            }
            return Container(
              decoration: BoxDecoration(
                  color: white,
                  border: Border.all(color: grey),
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                children: [
                  Container(
                    color: checkinController.allTable[index].length > num
                        ? red
                        : haian,
                    padding: EdgeInsets.all(5),
                    child: InkWell(
                      child: Row(
                        children: [
                          Expanded(
                              child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: 'Table ${index + 1} ',
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
                  Container(
                    height: 370,
                    // width: 250,
                    child: ListView.builder(
                      itemCount: checkinController.allTable[index].length,
                      itemBuilder: (context, i) {
                        if (checkinController.allTable[index][i].isChecked ==
                            false) {
                          color_checked = white;
                          color_text = black;
                        } else {
                          color_checked = green;
                          color_text = white;
                        }
                        return Container(
                            padding: EdgeInsets.all(5),
                            color: color_checked,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    checkinController.allTable[index][i].name!,
                                    style: TextStyle(
                                        fontSize: 14, color: color_text),
                                  ),
                                ),
                                checkinController
                                            .allTable[index][i].extend!.length >
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
                                    : const SizedBox.shrink(),
                              ],
                            ));
                      },
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
