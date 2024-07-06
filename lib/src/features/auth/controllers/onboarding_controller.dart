import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class OnboardingController extends GetxController {
  RxInt currentIndex = 0.obs;
  PageController pageController = PageController();
  final box = GetStorage();



  void next(int index) {
    if (index == 1) {
          Get.offNamed("/login");
    }
    if (currentIndex.value < 1) {
      currentIndex.value++;
      pageController.animateToPage(
        currentIndex.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void skip() {
    Get.offNamed("/login");
  box.write('isOnboardingComplete', true);

  }
bool loadOnboarding() {
  return box.read('isOnboardingComplete') ?? false;
}
}
