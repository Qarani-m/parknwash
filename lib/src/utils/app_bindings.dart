import 'package:get/get.dart';
import 'package:parknwash/src/features/auth/controllers/login_controller.dart';
import 'package:parknwash/src/features/auth/controllers/onboarding_controller.dart';
import 'package:parknwash/src/features/auth/controllers/signup_controller.dart';
import 'package:parknwash/src/features/home/controller/homecontroller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Homecontroller>(() => Homecontroller());
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<SignupController>(() => SignupController());
    Get.lazyPut<OnboardingController>(() => OnboardingController());
  }
}
