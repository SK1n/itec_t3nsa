import 'package:get/get.dart';
import 'package:itec_t3nsa/app/bindings/dalle_image_editor_service_binding.dart';
import 'package:itec_t3nsa/app/bindings/firebase_binding.dart';
import 'package:itec_t3nsa/app/bindings/landmark_detector_binding.dart';
import 'package:itec_t3nsa/app/controllers/firebase_controller.dart';
import 'package:itec_t3nsa/app/modules/create_account/create_account_page.dart';
import 'package:itec_t3nsa/app/modules/fullscreen/fullscreen_page.dart';
import 'package:itec_t3nsa/app/modules/gallery/gallery_page.dart';
import 'package:itec_t3nsa/app/modules/home/home_page.dart';
import 'package:itec_t3nsa/app/modules/login/login_page.dart';
import 'package:itec_t3nsa/app/modules/results/results_page.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.home;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomePage(),
      bindings: [
        LandmarkDetectorBinding(),
      ],
      children: [
        GetPage(
          name: _Paths.resultsPage,
          page: () => const ResultsPage(),
          bindings: [
            DALLEImageEditorServiceBinding(),
            FirebaseBinding(),
          ],
        ),
        GetPage(
          name: _Paths.gallery,
          page: () => const GallerPage(),
          bindings: [
            FirebaseBinding(),
          ],
        ),
      ],
    ),
    GetPage(
      name: _Paths.login,
      page: () => const LoginPage(),
      bindings: [
        FirebaseBinding(),
      ],
      children: [
        GetPage(
          name: _Paths.signUp,
          page: () => const CreateAccountPage(),
          bindings: [
            FirebaseBinding(),
          ],
        ),
      ],
    ),
    GetPage(
      name: _Paths.fullscren,
      page: () => const FullScreenPage(),
    ),
  ];
}
