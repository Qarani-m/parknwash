import 'package:get/get.dart';

import 'package:flutter/material.dart';

class OnboardingController extends GetxController {
  RxInt currentIndex = 0.obs;
  PageController pageController = PageController();


  void next(int index) {
    if (index == 1) {
          Get.offNamed("/login");
    }
    if (currentIndex.value < 1) {
      currentIndex.value++;
      pageController.animateToPage(
        currentIndex.value,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void skip() {
    Get.offNamed("/login");
  }
}
