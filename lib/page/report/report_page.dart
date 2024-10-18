import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_checkin/appbar.dart';
import 'package:web_checkin/assets/color_style.dart';
import 'package:web_checkin/controller/controller_checkin.dart';

import 'table/table.dart';

class ReportPage extends StatelessWidget {
  const ReportPage(this.refresh);
  final VoidCallback refresh;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MenuWidget(refresh),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Report',
                    style: TextStyle(fontSize: 30, color: haian),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Table1(),
                  ),
                ],
              ),
              Obx(
                () => Container(
                  width: MediaQuery.sizeOf(context).width,
                  margin: EdgeInsets.only(top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 60,
                        // padding: EdgeInsets.symmetric(horizontal: 5),
                        height: 40,
                        color: green,
                        child: Center(
                          child: Text(
                            checkinController.numChecked.value.toString(),
                            style: TextStyle(color: white),
                          ),
                        ),
                      ),
                      Container(
                        width: 60,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        height: 40,
                        color: grey,
                        child: Center(
                          child: Text(
                            checkinController.numCheck.value.toString(),
                            style: TextStyle(color: white),
                          ),
                        ),
                      ),
                      Container(
                        width: 60,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        height: 40,
                        color: orange,
                        child: Center(
                          child: Text(
                            checkinController.numAll.value.toString(),
                            style: TextStyle(color: white),
                          ),
                        ),
                      ),
                      Container(
                        width: 60,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        height: 40,
                        color: red,
                        child: Center(
                          child: Text(
                            checkinController.numExt.value.toString(),
                            style: TextStyle(color: white),
                          ),
                        ),
                      ),
                      Container(
                        width: 60,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        height: 40,
                        color: haian,
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              refresh();
                            },
                            child: Text(
                              'Reload',
                              style: TextStyle(color: white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
