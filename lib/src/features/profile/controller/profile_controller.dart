import 'dart:convert';

import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  final box = GetStorage();

  RxString displayName = ''.obs;
  RxString createdAt = ''.obs;
  RxString email = ''.obs;

  @override
  void onInit() {
    super.onInit();
    updateDetails();
  }

  void updateDetails() {
    String? userJson = box.read('userData');
    if (userJson != null) {
      Map<String, dynamic> userData = jsonDecode(userJson);
      displayName.value = userData['displayName'];
      createdAt.value = userData['createdAt'];
      email.value = userData['email'];
    } else {
      print('No user data found in storage.');
    }
  }

  Future<void> tellYourFriends() async {
    await FlutterShare.share(
        title: 'ParkNWash',
        text: 'Share ParkNWash',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }

  void goToPayments() {
    Get.toNamed("/payment-page");
  }

  void resetPassword() {}

  void changeProfilePic() {
    print("profile");
  }
}
