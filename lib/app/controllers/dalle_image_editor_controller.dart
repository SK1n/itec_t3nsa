import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class DALLEImageEditorController {
  final String apiKey;

  DALLEImageEditorController(this.apiKey);

  Future<String> editImage(String description, String edits) async {
    Logger logger = Logger();

    String apiKey = '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';

    logger.d(description);
    try {
      var url = Uri.parse('https://api.openai.com/v1/images/generations');
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey'
        },
        body: jsonEncode({
          'prompt': "$description 50 years ago",
          "n": 1,
          "size": "1024x1024",
        }),
      );

      logger.d(response.reasonPhrase);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        logger.d(jsonResponse['data'][0]['url']);
        return jsonResponse['data'][0]['url'];
      }
    } on Exception catch (e) {
      logger.d(e.toString());
    }
    return '';
  }
}
