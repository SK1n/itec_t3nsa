import 'package:get/get.dart';
import 'package:itec_t3nsa/app/controllers/maps_controller.dart';

class MapsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapsController>(() => MapsController());
  }
}
