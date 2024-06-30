import 'dart:convert';

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
