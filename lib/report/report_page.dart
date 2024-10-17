import 'package:flutter/material.dart';
import 'package:web_checkin/appbar.dart';
import 'package:web_checkin/assets/color_style.dart';

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
              Container(
                margin: EdgeInsets.only(top: 50),
                width: MediaQuery.sizeOf(context).width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
