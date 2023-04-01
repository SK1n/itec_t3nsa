import 'dart:io';

import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseVisionController extends GetxController {
  Future<List<ImageLabel>> detectLabels(String path) async {
    InputImage inputImage;
    final ImageLabelerOptions options =
        ImageLabelerOptions(confidenceThreshold: 0.5);
    final imageLabeler = ImageLabeler(options: options);

    final imagePicker =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    final file = File(imagePicker!.path);

    inputImage = InputImage.fromFile(file);
    return await imageLabeler.processImage(inputImage);
  }
}
