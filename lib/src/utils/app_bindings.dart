import 'package:get/get.dart';
import 'package:parknwash/src/features/auth/controllers/login_controller.dart';
import 'package:parknwash/src/features/auth/controllers/onboarding_controller.dart';
import 'package:parknwash/src/features/auth/controllers/signup_controller.dart';
import 'package:parknwash/src/features/home/controller/homecontroller.dart';
import 'package:parknwash/src/features/profile/controller/profile_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<Homecontroller>(Homecontroller());
    Get.put<LoginController>(LoginController());
    Get.put<SignupController>(SignupController());
    Get.put<OnboardingController>(OnboardingController());
    Get.put<ProfileController>(ProfileController());
  }
}
