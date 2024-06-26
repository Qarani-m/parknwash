import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homecontroller extends GetxController {
  Rx<Color> changeColor = Color(0xFF252525).obs;

  void changeButtonColor(int index) {
    print(index);
  }
}
