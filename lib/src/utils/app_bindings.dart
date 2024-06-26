import 'package:get/get.dart';
import 'package:parknwash/src/features/home/controller/homecontroller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Homecontroller>(() => Homecontroller());
  }
}
