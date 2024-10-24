import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:web_checkin/assets/variable.dart';
import 'package:web_checkin/controller/controller_page.dart';
import 'package:web_checkin/page/mobile/search_checkin/mobile_page.dart';

import 'assets/horizontal_scroll.dart';
import 'page/checkin/checkin_page.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    screenWidth < 600 ? isMobile = true : isMobile = false;
    isMobile == true
        ? pageController.dividerPage.value = 'MobileCheckin'
        : null;
    return GetMaterialApp(
      title: 'Check-in',
      navigatorKey: navigatorKey,
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
      scrollBehavior: CustomHorizontalScroll(),
      home: isMobile == false ? CheckInPage() : MobilePage(),
      builder: EasyLoading.init(),
    );
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
