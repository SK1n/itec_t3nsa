import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.hourGlass
      ..userInteractions = false
      ..loadingStyle = EasyLoadingStyle.custom
      ..backgroundColor = Colors.white
      ..indicatorColor = Colors.pinkAccent
      ..textColor = Colors.white;
  }
}
