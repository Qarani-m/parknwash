import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homecontroller extends GetxController {
  Rx<Color> changeColor = Color(0xFF252525).obs;
  Rx<Color> baseColor = Color(0xFFDDD9F0).obs;

  RxInt selectedCategoryIndex = 0.obs;
  void changeSelectedCategory(int index) {
    selectedCategoryIndex.value = index;
  }

  void startParking() {
    print(selectedCategoryIndex.value);
  }

  void goToProfile() {
    Get.toNamed("/profile-main");
  }

  void locationButton() {
    print("locatio");
  }

  void logout() {
    print("logout");

  }
  void tellYourFriends() {
    print("tell a friend");

  }
  void goToPayments() {
    print("payments");
  }

  void changeProfilePic() {
    print("profile");
  }
}
