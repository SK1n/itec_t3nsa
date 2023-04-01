import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itec_t3nsa/app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    GetMaterialApp(
      title: 'iTEC - T3nsa',
      getPages: AppPages.routes,
      initialRoute: AppPages.initial,
    ),
  );
}
