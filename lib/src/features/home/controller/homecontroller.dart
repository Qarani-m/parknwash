import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Homecontroller extends GetxController {
  Rx<Color> changeColor = const Color(0xFF252525).obs;
  Rx<Color> baseColor = const Color(0xFFDDD9F0).obs;


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

  void logout(BuildContext context) {
    Get.bottomSheet(
      Container(
        height: 150.h,
        width: double.maxFinite,
        decoration: BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.sp),
            topRight: Radius.circular(20.sp)
          )
        ),
        child: Column(children: [
          Text("Log Out ?", style: Theme.of(context).textTheme.bodyMedium,), 
          const Text("Are you sure you want to log out?"),
          Row(
            children: [
              Container(
                height: 50.h,
                width: 100.w,
                decoration: const BoxDecoration(
                  
                ),
              )
            ],
          )
        ],),
      )
    );

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
