import 'package:get/get.dart';
import 'package:itec_t3nsa/app/modules/home/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
