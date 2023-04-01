import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CamController extends GetxController {
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

  Future getImage(ImageSource imageSource) async {
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: imageSource);
    if (image != null) {
      await _convertImageToPng(image);
    } else {
      Get.snackbar("Error", "No Selected Image",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> _convertImageToPng(XFile image) async {
    final originalBytes = await image.readAsBytes();
    final compressedBytes = await FlutterImageCompress.compressWithList(
      originalBytes,
      format: CompressFormat.png,
      quality: 50, // adjust quality as per your need
    );
    final newFile = File(image.path);
    await newFile.writeAsBytes(compressedBytes);
    selectedImagePath.value = newFile.path;
  }
}
