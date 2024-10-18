import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_checkin/assets/color_style.dart';
import 'dart:html' as html;

import 'package:web_checkin/assets/global.dart';

class ExportButton extends StatefulWidget {
  @override
  _ExportButtonState createState() => _ExportButtonState();
}

class _ExportButtonState extends State<ExportButton> {
  // bool isExport = false;

  Future<void> downloadFile() async {
    final url = '$SERVER/CheckIn/ExportExcel'; // Replace with your direct link
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print('Export history done');
      final bytes = response.bodyBytes;
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download',
            'List Checked.xlsx') // Change file name and extension as needed
        ..click();
      html.Url.revokeObjectUrl(url);
    } else {
      print('Error export: ' + response.statusCode.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () {
            downloadFile();
            // setState(() {
            //   isExport = !isExport;
            // });
          },
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(haian),
              minimumSize: MaterialStateProperty.all(Size(100, 40))),
          child: Text('Export Excel'),
        ),
      ],
    );
  }
}
