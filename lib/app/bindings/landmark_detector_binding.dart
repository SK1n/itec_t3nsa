import 'package:get/get.dart';
import 'package:itec_t3nsa/app/controllers/landmark_detector_controller.dart';

class LandmarkDetectorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LandmarkDetectorController>(() => LandmarkDetectorController());
  }
}
