import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itec_t3nsa/app/controllers/firebase_controller.dart';
import 'package:itec_t3nsa/app/controllers/landmark_detector_controller.dart';
import 'package:itec_t3nsa/app/global_widgets/custom_scaffold.dart';
import 'package:itec_t3nsa/app/routes/app_pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final LandmarkDetectorController landmarkDetectorController = Get.find();
    final FirebaseController firebaseController = Get.put(FirebaseController());
    return CustomScaffold(
      [
        SliverToBoxAdapter(
          child: Column(
            children: [
              FilledButton(
                onPressed: () async {
                  String? description =
                      await landmarkDetectorController.getLandmark();
                  debugPrint(description!);
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
              FilledButton(
                onPressed: () async {
                  await firebaseController.signOut();
                },
                style: FilledButton.styleFrom(
                  minimumSize: Size(Get.width - 20, 30),
                ),
                child: const Text(
                  'Sign out',
                ),
              ),
            ],
          ),
        )
      ],
      title: "Home",
    );
  }
}
