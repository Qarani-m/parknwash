import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homecontroller extends GetxController {
  Rx<Color> changeColor = Color(0xFF252525).obs;
  Rx<Color> baseColor = Color(0xFFDDD9F0).obs;
  RxInt selectedCategoryIndex = 0.obs;
  void changeSelectedCategory(int index) {
    selectedCategoryIndex.value = index;
  }
}
