import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_checkin/assets/color_style.dart';
import 'package:web_checkin/assets/variable.dart';
import 'package:web_checkin/page/checkin/checkin_page.dart';
import 'package:web_checkin/page/mobile/report/report_page.dart';
import 'package:web_checkin/page/mobile/search_checkin/mobile_page.dart';

import 'controller/controller_page.dart';
import 'page/report/report_page.dart';

// ignore: must_be_immutable
class MenuWidget extends StatelessWidget {
  MenuWidget(this.refresh);
  final VoidCallback refresh;

  Color? colorDividerCheckin;
  Color? colorDividerReport;
  Color? colorDividerMobileChecin;
  Color? colorDividerMobileReport;

  @override
  Widget build(BuildContext context) {
    switch (pageController.dividerPage.value) {
      case 'Checkin':
        colorDividerCheckin = white;
        colorDividerReport = haian;
      case 'Report':
        colorDividerCheckin = haian;
        colorDividerReport = white;
      case 'MobileCheckin':
        colorDividerMobileChecin = white;
        colorDividerMobileReport = haian;
      case 'MobileReport':
        colorDividerMobileChecin = haian;
        colorDividerMobileReport = white;
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
              isMobile == true
                  ? Row(
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: haian,
                              elevation: 0.0,
                            ),
                            onPressed: () {
                              pageController.dividerPage.value =
                                  'MobileCheckin';
                              Get.to(() => MobilePage());
                            },
                            child: Column(
                              children: [
                                Container(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text('Mobile')),
                                SizedBox(
                                  width: 90,
                                  child: Divider(
                                    thickness: 2,
                                    color: colorDividerMobileChecin,
                                  ),
                                )
                              ],
                            )),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: haian,
                              elevation: 0.0,
                            ),
                            onPressed: () {
                              pageController.dividerPage.value = 'MobileReport';
                              Get.to(() => ReportMobilePage(refresh));
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
                                    color: colorDividerMobileReport,
                                  ),
                                )
                              ],
                            )),
                      ],
                    )
                  : Row(
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
                              Get.to(() => ReportPage(refresh));
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
                    )
            ],
          ),
        ],
      ),
    );
  }
}
