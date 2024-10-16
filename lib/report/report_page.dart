import 'package:flutter/material.dart';
import 'package:web_checkin/appbar.dart';
import 'package:web_checkin/assets/color_style.dart';

import 'table/table.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MenuWidget(),
              SizedBox(
                height: 10,
              ),
              Text(
                'Report',
                style: TextStyle(
                    fontSize: 30,
                    // fontWeight: FontWeight.bold,
                    color: haian),
              ),
              Container(
                margin: EdgeInsets.all(20),
                // padding: EdgeInsets.all(5),
                // decoration: BoxDecoration(
                //     color: white,
                //     border: Border.all(color: grey),
                //     borderRadius: BorderRadius.circular(5)),
                child: Table1(),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
