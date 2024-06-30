import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parknwash/src/features/auth/controllers/helpers/auth_service.dart';
import 'package:parknwash/src/features/auth/controllers/helpers/input_validation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  late InputValidator _inputValidator;
  @override
  void onInit() {
    super.onInit();
    emailController.text = "emqarani2@gmail.com";
    passwordController.text = "Martin7982!";
    nameController.text = "Martin";
    phoneController.text = "1234567890";
    _inputValidator = InputValidator(
      emailController: emailController,
      passwordController: passwordController,
      nameController: nameController,
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
    if (validateInput()) {
      print('Registering with email and password');
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final name = nameController.text.trim();
      final phone = phoneController.text.trim();

      String response = await AuthService().signupUser(
          email: email, password: password, name: name, phone: phone);

      if (response == "Success") {
        Get.snackbar('Success', 'Logged in successfully');
        Get.offNamed("/home");
      } else {
        
      }
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
      if (!_inputValidator.isNameValid()) {
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
    // Dispose of controllers to free up resources
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();  // Always call super.dispose() last
  }

}
