import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parknwash/src/features/auth/controllers/helpers/auth_service.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  void loginGoogle() async {
    try {
      Map<String, dynamic> result =
          await AuthService().signInOrRegisterWithGoogle();

      if (result["status"] == "success") {
        Get.snackbar(
          "Success",
          "Successfully signed in",
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.offNamed("/home");
      } else {
        throw Exception(result["message"]);
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Sign-in failed: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> loginEmailAndPassword() async {
    try {
      final user = await _authService.signInWithEmailAndPassword(
          "emqarani2@gmail.com", "Martin7982!");
      if (user != null) {
        Get.snackbar('Success', 'Logged in successfully');
        Get.offAllNamed('/home');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }


   @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();  // Always call super.dispose() last
  }

}
