
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parknwash/src/features/auth/controllers/helpers/auth_service.dart';
import 'package:parknwash/src/features/auth/controllers/helpers/input_validation.dart';

class SignupController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  late InputValidator _inputValidator;
  @override
  void onInit() {
    super.onInit();
    // emailController.text = "emqarani2@gmail.com";
    // passwordController.text = "Martin7982!";
    // nameController.text = "Martin";
    // phoneController.text = "1234567890";
    _inputValidator = InputValidator(
      emailController: emailController,
      passwordController: passwordController,
      firstNameController: firstNameController,
      lastNameController: lastNameController,
      confirmPasswordController: confirmPasswordController,
      phoneController: phoneController,
    );
  }

  Future<void> registerGoogle() async {
    try {
      Map<String, dynamic> result =
          await AuthService().signInOrRegisterWithGoogle();

      if (result["status"] == "success") {
        if (result["isNewUser"]) {
          await AuthService().createUserProfile(result["userData"]);
        } else {}
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

  Future<void> registerEmailAndPassword() async {
    if (confirmPasswordController.text.trim() ==
            passwordController.text.trim() &&
        validateInput()) {
      print('Registering with email and password');
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final name =
          '${firstNameController.text.trim()} ${lastNameController.text.trim()}';
      final phone = phoneController.text.trim();

      String response = await AuthService().signupUser(
          email: email, password: password, name: name, phone: phone);

      if (response == "Success") {
        Get.snackbar('Success', 'Logged in successfully');
        Get.offNamed("/home");
      } else {}
    }
  }

  bool validateInput() {
    if (_inputValidator.validateAll()) {
      return true;
    } else {
      if (!_inputValidator.isEmailValid()) {
        Get.snackbar('Validation Error', _inputValidator.validateEmail()!,
            snackPosition: SnackPosition.BOTTOM);
        return false;
      }
      if (!_inputValidator.isPasswordValid()) {
        Get.snackbar('Validation Error', _inputValidator.validatePassword()!,
            snackPosition: SnackPosition.BOTTOM);
        return false;
      }
      if (!_inputValidator.isFirstNameValid()) {
        Get.snackbar('Validation Error', _inputValidator.validateName()!,
            snackPosition: SnackPosition.BOTTOM);
        return false;
      }
       if (!_inputValidator.isLastNameValid()) {
        Get.snackbar('Validation Error', _inputValidator.validateName()!,
            snackPosition: SnackPosition.BOTTOM);
        return false;
      }
      if (!_inputValidator.isPhoneValid()) {
        Get.snackbar('Validation Error', _inputValidator.validatePhone()!,
            snackPosition: SnackPosition.BOTTOM);
        return false;
      }
    }
    return false;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose(); // Always call super.dispose() last
  }
}
