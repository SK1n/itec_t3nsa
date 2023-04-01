import 'package:get/get.dart';
import 'package:itec_t3nsa/app/controllers/camera_controller.dart';

class CamBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CamController>(() => CamController());
  }
}
