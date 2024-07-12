import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:parknwash/src/features/auth/controllers/helpers/auth_service.dart';
import 'package:parknwash/src/utils/constants/colors.dart';

class Homecontroller extends GetxController {
  Rx<Color> changeColor = const Color(0xFF252525).obs;
  Rx<Color> baseColor = const Color(0xFFDDD9F0).obs;

  RxString userName = "Hello, 👋".obs;

  final box = GetStorage();

  @override
  Future<void> onInit() async {
    super.onInit();
    bool isNotificationsAllowed =
        await AwesomeNotifications().isNotificationAllowed();
    if (!isNotificationsAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
    updateUserName();
  }

  void updateUserName() {
    String? userJson = box.read('userData');
    if (userJson != null) {
      Map<String, dynamic> userData = jsonDecode(userJson);
      String displayName = userData['displayName'] ?? '';
      userName.value = "Hello, 👋 ${displayName.split(' ')[0]}";
    } else {
      print('No user data found in storage.');
      userName.value = "Hello, 👋";
    }
  }

  RxInt selectedCategoryIndex = 0.obs;
  void changeSelectedCategory(int index) {
    selectedCategoryIndex.value = index;
  }

  void startParking() {
    print(selectedCategoryIndex.value);

    box.write("category", selectedCategoryIndex.toString());
    Get.toNamed("/locations");
  }

  void goToProfile() {
    Get.toNamed("/profile-main");
  }

  void locationButton() {
    print("locatio");
  }

  void logout(BuildContext context) {
    final theme = Get.theme;
    Get.bottomSheet(Container(
      padding: EdgeInsets.only(top: 15.h),
      height: 150.h,
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.sp),
              topRight: Radius.circular(20.sp))),
      child: Column(
        children: [
          const Text("Are you sure you want to log out?"),
          SizedBox(
            height: 30.h,
          ),
          GestureDetector(
            onTap: () {
              AuthService().signOut();
              box.remove("userData");
              Get.offNamed("/login");
            },
            child: Container(
              padding: EdgeInsets.only(left: 23.w, right: 23.w),
              height: 50.h,
              width: 360.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.accentColor,
                  borderRadius: BorderRadius.circular(15.sp)),
              child: Text(
                "Confirm",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    ));

    print("logout");
  }
}
