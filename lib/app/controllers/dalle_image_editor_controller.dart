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
      // EasyLoading.dismiss();
      // return [
      //   'https://firebasestorage.googleapis.com/v0/b/itec-t3nsa.appspot.com/o/VjrPV2baWgOKfXfyhryjjxeFqt53%2Fpng%26skoid%3D6aaadede-4fb3-4698-a8f6-684d7786b067%26sktid%3Da48cca56-e6da-484e-a814-9c849652bcb3%26skt%3D2023-04-01T21%253A48%253A19Z%26ske%3D2023-04-02T21%253A48%253A19Z%26sks%3Db%26skv%3D2021-08-06%26sig%3DX7sYK%252B1pYqhRlGJBvMEnNVgVOMG1Fgv6TJI1TnIc4ts%253D?alt=media&token=f07e2617-cd6e-4097-9643-897288f33634',
      //   'https://firebasestorage.googleapis.com/v0/b/itec-t3nsa.appspot.com/o/VjrPV2baWgOKfXfyhryjjxeFqt53%2Fpng%26skoid%3D6aaadede-4fb3-4698-a8f6-684d7786b067%26sktid%3Da48cca56-e6da-484e-a814-9c849652bcb3%26skt%3D2023-04-01T21%253A48%253A19Z%26ske%3D2023-04-02T21%253A48%253A19Z%26sks%3Db%26skv%3D2021-08-06%26sig%3DURF3RIFD2l9SSdUVzZHAYWLIXazGoq%252B3uyWNkETx0gI%253D?alt=media&token=1f41ff3a-5a44-4efb-a97e-46ab8cda686a',
      // ];
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
