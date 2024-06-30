import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    emailController.text = "emqarani@gmail.com";
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

  void registerGoogle() {
    // Implement Google registration logic
    print('Registering with Google');
  }

  Future<void> registerEmailAndPassword() async {
    if (validateInput()) {
      print('Registering with email and password');
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      final name = nameController.text.trim();
      final phone = phoneController.text.trim();

      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
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
}
