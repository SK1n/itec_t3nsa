import 'package:get/get.dart';
import 'package:itec_t3nsa/app/controllers/firebase_vision.dart';

class FirebaseVisionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirebaseVisionController>(() => FirebaseVisionController());
  }
}
