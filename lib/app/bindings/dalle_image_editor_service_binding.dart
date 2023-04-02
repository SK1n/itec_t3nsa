import 'package:get/get.dart';
import 'package:itec_t3nsa/app/controllers/dalle_image_editor_controller.dart';

class DALLEImageEditorServiceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DALLEImageEditorController>(() => DALLEImageEditorController());
  }
}
