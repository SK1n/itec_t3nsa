import 'package:get/get.dart';
import 'package:itec_t3nsa/app/data/services/dalle_image_editor_service.dart';

class DALLEImageEditorServiceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DALLEImageEditorService>(
        () => DALLEImageEditorService(const String.fromEnvironment('API_KEY')));
  }
}
