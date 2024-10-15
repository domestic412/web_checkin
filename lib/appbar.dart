import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_checkin/assets/color_style.dart';
import 'package:web_checkin/checkin/checkin_page.dart';

import 'controller/controller_page.dart';

class MenuWidget extends StatefulWidget {
  MenuWidget({super.key});

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  Color? colorDividerCheckin;
  Color? colorDividerReport;

  @override
  Widget build(BuildContext context) {
    switch (pageController.dividerPage.value) {
      case 'Checkin':
        colorDividerCheckin = white;
        colorDividerReport = haian;
      case 'Report':
        {
          colorDividerCheckin = haian;
          colorDividerReport = white;
        }
    }
    return Container(
      height: 50,
      color: haian,
      // margin: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: haian,
                    elevation: 0.0,
                  ),
                  onPressed: () {
                    pageController.dividerPage.value = 'Checkin';
                    Get.to(() => CheckInPage());
                  },
                  child: Column(
                    children: [
                      Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Text('Check In')),
                      SizedBox(
                        width: 90,
                        child: Divider(
                          thickness: 2,
                          color: colorDividerCheckin,
                        ),
                      )
                    ],
                  )),
              // SizedBox(width: 10),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: haian,
                    elevation: 0.0,
                  ),
                  onPressed: () {
                    pageController.dividerPage.value = 'Report';
                    // Get.to(() => ReportPage());
                  },
                  child: Column(
                    children: [
                      Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Text('Report')),
                      SizedBox(
                        width: 90,
                        child: Divider(
                          thickness: 2,
                          color: colorDividerReport,
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
