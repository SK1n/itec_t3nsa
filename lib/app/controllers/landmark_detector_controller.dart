import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:image/image.dart' as img;

class LandmarkDetectorController extends GetxController {
  static const landmarkChannel =
      MethodChannel('com.example.itec/getLandmarksChannel');

  Future getLandmark(bool openCamera) async {
    Logger logger = Logger();
    final XFile? imagePicker = await ImagePicker().pickImage(
        source: openCamera ? ImageSource.camera : ImageSource.gallery);
    if (imagePicker?.path != null) {
      EasyLoading.show();
      try {
        logger.d(imagePicker!.path);
        String landmark = await landmarkChannel
            .invokeMethod("getLandmarks", {"image": imagePicker.path});
        EasyLoading.dismiss();
        logger.d("landmark$landmark" "a");
        return landmark;
      } on PlatformException catch (e) {
        logger.d(e.message);
      }
    } else {
      EasyLoading.dismiss();
    }
  }
}
