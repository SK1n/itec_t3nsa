import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itec_t3nsa/app/controllers/camera_controller.dart';
import 'package:itec_t3nsa/app/controllers/firebase_vision.dart';
import 'package:itec_t3nsa/app/controllers/landmark_detector_controller.dart';
import 'package:itec_t3nsa/app/global_widgets/custom_scaffold.dart';
import 'package:itec_t3nsa/app/routes/app_pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final CamController cameraController = Get.find();
    final FirebaseVisionController firebaseVisionController = Get.find();
    final LandmarkDetectorController landmarkDetectorController = Get.find();
    return CustomScaffold([
      SliverToBoxAdapter(
        child: Column(
          children: [
            FilledButton(
              onPressed: () async {
                String description =
                    await landmarkDetectorController.getLandmark();
                Get.toNamed(
                  Routes.resultsPage,
                  arguments: [
                    description,
                  ],
                );
              },
              style: FilledButton.styleFrom(
                minimumSize: Size(Get.width - 20, 30),
              ),
              child: const Text(
                'Open photo',
              ),
            ),
            FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(
                minimumSize: Size(Get.width - 20, 30),
              ),
              child: const Text(
                'Upload photo from gallery',
              ),
            ),
          ],
        ),
      )
    ]);
  }
}
