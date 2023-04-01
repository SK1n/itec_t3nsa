import 'package:get/get.dart';
import 'package:itec_t3nsa/app/bindings/camera_binding.dart';
import 'package:itec_t3nsa/app/bindings/dalle_image_editor_service_binding.dart';
import 'package:itec_t3nsa/app/bindings/firebase_vision_binding.dart';
import 'package:itec_t3nsa/app/bindings/landmark_detector_binding.dart';
import 'package:itec_t3nsa/app/modules/camera_page/camera_page.dart';
import 'package:itec_t3nsa/app/modules/home/home_binding.dart';
import 'package:itec_t3nsa/app/modules/home/home_page.dart';
import 'package:itec_t3nsa/app/modules/results_page/results_page.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.home;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomePage(),
      bindings: [
        HomeBinding(),
        CamBinding(),
        FirebaseVisionBinding(),
        LandmarkDetectorBinding(),
      ],
      children: [
        GetPage(
          name: _Paths.cameraPage,
          page: () => const CameraPage(),
        ),
        GetPage(
            name: _Paths.resultsPage,
            page: () => const ResultsPage(),
            bindings: [
              DALLEImageEditorServiceBinding(),
            ]),
      ],
    ),
  ];
}
