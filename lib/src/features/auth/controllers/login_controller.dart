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
          snackPosition: SnackPosition.TOP,
        );
        Get.offNamed("/home");
      } else {
        throw Exception(result["message"]);
      }
    } catch (e) {
      Get.snackbar(
        "Login with google error",
        "Sign-in failed: You probably dont have an internet connection",
        snackPosition: SnackPosition.TOP,
        colorText: Colors.black,
      );
    }
  }

  Future<void> loginEmailAndPassword() async {
        FocusScope.of(Get.context!).unfocus();

    
    try {
      final user = await _authService.signInWithEmailAndPassword(
          emailController.text.trim(), passwordController.text.trim());
      if (user != null) {
        Get.snackbar('Success', 'Logged in successfully');
        Get.offAllNamed('/home');
      }
    } catch (e) {
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
