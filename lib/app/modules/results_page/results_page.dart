import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:itec_t3nsa/app/controllers/dalle_image_editor_controller.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DALLEImageEditorController dalle = Get.find();
    final String description = Get.arguments[0];
    return Scaffold(
      body: FutureBuilder(
          future: dalle.editImage(description, 'Increase saturation'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Image.network(snapshot.data!);
            } else {
              return Container();
            }
          }),
    );
  }
}
