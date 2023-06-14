import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:itec_t3nsa/app/controllers/firebase_controller.dart';
import 'package:logger/logger.dart';

class DALLEImageEditorController extends GetxController {
  DALLEImageEditorController();

  final FirebaseController _firebaseController = Get.put(FirebaseController());

  Future<List<dynamic>> editImage(String description, {String? city}) async {
    Logger logger = Logger();

    String apiKey = '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';

    var images;
    try {
      EasyLoading.show();
      var url = Uri.parse('https://api.openai.com/v1/images/generations');
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${const String.fromEnvironment("API_KEY")}'
        },
        body: jsonEncode({
          'prompt': "$description$city vintage, timeless, ancient ",
          "n": 4,
          "size": "256x256",
        }),
      );

      logger.d(response.reasonPhrase);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        logger.d(jsonResponse['data'][0]['url']);
        images = await uploadToFirebase(jsonResponse);
        EasyLoading.dismiss();
        return images;
      }
      EasyLoading.dismiss();
    } on Exception catch (e) {
      EasyLoading.showError(
          "Sorry, we couldn't generate the images\nPlease try again");
    }
    return images;
  }

  uploadToFirebase(jsonResponse) async {
    List<String> urls = [];
    for (int index = 0; index < 4; index++) {
      try {
        String? downloadUrl =
            await _firebaseController.uploadImageFromUrlToFirebaseStorage(
                jsonResponse['data'][index]['url']);
        urls.add(downloadUrl!);
        await _firebaseController.uploadDataToFirestore(downloadUrl);
      } on Exception catch (e) {
        rethrow;
      }
    }
    return urls;
  }
}
