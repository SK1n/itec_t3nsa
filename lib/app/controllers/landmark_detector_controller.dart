import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:image/image.dart' as img;

class LandmarkDetectorController extends GetxController {
  static const landmarkChannel =
      MethodChannel('com.example.itec/getLandmarksChannel');

  Future getLandmark() async {
    Logger logger = Logger();
    final XFile? imagePicker =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicker?.path != null) {
      try {
        logger.d(imagePicker!.path);
        final uInt8 = await imagePicker
            .readAsBytes()
            .then((value) => value.buffer.asUint8List());
        final bitmap = img.decodeImage(uInt8);
        String landmark = await landmarkChannel
            .invokeMethod("getLandmarks", {"image": imagePicker.path});

        logger.d(landmark);
        return landmark;
      } on PlatformException catch (e) {
        logger.d(e.message);
      }
    }
  }
}
