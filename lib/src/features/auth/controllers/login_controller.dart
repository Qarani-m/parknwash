import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:parknwash/src/features/auth/controllers/helpers/auth_service.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  RxBool isLogingIn = false.obs;

  // Add a variable to store user data
  Rx<Map<String, dynamic>> userData = Rx<Map<String, dynamic>>({});

  Future<void> loginGoogle() async {
    isLogingIn.value = true;
    try {
      Map<String, dynamic> result =
          await _authService.signInOrRegisterWithGoogle();

      if (result["status"] == "success") {
        String uid = result["userData"]['uid'];
        await fetchUserData(uid);

        Get.snackbar(
          "Success",
          "Successfully signed in",
          snackPosition: SnackPosition.TOP,
        );

        // Navigate to home screen
        Get.offNamed("/home");
        isLogingIn.value = false;
      } else {
        isLogingIn.value = false;
           Get.snackbar(
        "Login with Google error",
        "Sign-in failed: You probably don't have an internet connection",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.black,
      );
      }
    } catch (e) {
      isLogingIn.value = false;
      Get.snackbar(
        "Login with Google error",
        "Sign-in failed: You probably don't have an internet connection",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.black,
      );
    }
  }

  Future<void> fetchUserData(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists) {
        userData.value = userDoc.data() as Map<String, dynamic>;

        DateTime createdAtDate = userData.value['createdAt'].toDate();
        int year = createdAtDate.year;
        String monthName = DateFormat('MMMM')
            .format(createdAtDate); // Gets full month name (e.g., June)

        Map<String, dynamic> localData = {
          "displayName": userData.value['displayName'],
          "email": userData.value["email"],
          "phoneNumber": userData.value['phoneNumber'],
          "uid": uid,
          'createdAt':
              "$monthName, $year", // Use regular DateTime for local storage
        };

        AuthService().saveUserData(localData);

        print("User data fetched: ${userData.value['createdAt']}");
      } else {
        print("User document does not exist in Firestore");

        Get.snackbar(
          "Error",
          "User document does not exist in Firestore",
          snackPosition: SnackPosition.TOP,
          colorText: Colors.red,
        );
      }
    } catch (e) {
      print("Error fetching user data: $e");
      Get.snackbar(
        "Error",
        "Failed to fetch user data",
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.red,
      );
    }
  }

  Future<void> loginEmailAndPassword() async {
          isLogingIn.value = true;
    FocusScope.of(Get.context!).unfocus();
    

    try {
      final user = await _authService.signInWithEmailAndPassword(
          emailController.text.trim(), passwordController.text.trim());
      if (user != null) {
        Get.snackbar('Success', 'Logged in successfully');
        Get.offAllNamed('/home');
          isLogingIn.value = false;

      }
    } catch (e) {
        isLogingIn.value = false;
      Get.snackbar('Error', "Invalid email or Password");
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose(); // Always call super.dispose() last
  }
}
