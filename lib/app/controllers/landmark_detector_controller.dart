import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itec_t3nsa/pigeon.dart';
import 'package:logger/logger.dart';

class LandmarkDetectorController extends GetxController with StateMixin {
  static const landmarkChannel = MethodChannel('sk1n/landmarkDetector');

  Future getLandmark() async {
    Logger logger = Logger();
    final XFile? imagePicker =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imagePicker?.path != null) {
      try {
        logger.d('landmark');
      } catch (e) {
        logger.d(e);
      }
    }
  }
}
