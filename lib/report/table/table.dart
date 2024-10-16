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
            return Container(
              decoration: BoxDecoration(
                  color: white,
                  border: Border.all(color: grey),
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                children: [
                  Container(
                    // width: 200,
                    color: checkOver12(checkinController.allTable[index].length)
                        ? haian
                        : red,
                    padding: EdgeInsets.all(5),
                    child: InkWell(
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            'Table ${index + 1}',
                            style: style_label_table,
                          )),
                          Text(
                            /// bắt đầu từ index = 0 tương đương listTable1
                            '${calculator(checkinController.allTable[index])} / ${checkinController.allTable[index].length}',
                            style: style_label_table,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 350,
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

  checkOver10(int num) {
    if (num > 10) {
      return false;
    } else {
      return true;
    }
  }

  checkOver12(int num) {
    if (num > 12) {
      return false;
    } else {
      return true;
    }
  }
}
