import 'package:expense/controllers/app_comtroller.dart';
import 'package:get/get.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AppController());
  }
}
