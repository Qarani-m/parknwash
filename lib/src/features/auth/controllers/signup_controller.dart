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

  Rx<Color> normalColor = const Color(0xFFE0E0E0).obs;
  Rx<Color> errorlColor = const Color(0xFFDC143c).obs;

  RxBool isLogingIn = false.obs;

  RxBool isFirstNameError = false.obs;
  RxBool isLastNameError = false.obs;
  RxBool isEmailError = false.obs;
  RxBool isPhoneNumberError = false.obs;
  RxBool isPasswordError = false.obs;

  RxBool isConfirmedPasswordError = false.obs;
  RxBool obscureText = true.obs;

  void obscureToggle() {
    obscureText.value = !obscureText.value;
  }

  late InputValidator _inputValidator;
  @override
  void onInit() {
    super.onInit();
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
    isLogingIn.value = true;
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
          snackPosition: SnackPosition.TOP,
        );

        Get.offNamed("/home");
        isLogingIn.value = false;
      } else {
        isLogingIn.value = false;
        Get.snackbar(
          "Error",
          "Sign-in failed:",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        throw Exception(result["message"]);
      }
    } catch (e) {
      isLogingIn.value = false;

      Get.snackbar(
        "Error",
        "Sign-in failed: $e",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    isLogingIn.value = false;
  }

  Future<void> registerEmailAndPassword() async {
    isLogingIn.value = true;
    if (confirmPasswordController.text.trim() ==
            passwordController.text.trim() &&
        validateInput()) {
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
        isLogingIn.value = false;
      } else {}
    } else {
      if (confirmPasswordController.text.trim() !=
          passwordController.text.trim()) {
        isConfirmedPasswordError.value = true;
        Get.snackbar('Validation Error', "Password mismatch!",
            snackPosition: SnackPosition.TOP);

        isLogingIn.value = false;
      }
    }
    isLogingIn.value = false;
  }

  bool validateInput() {
    isLogingIn.value = true;

    if (_inputValidator.validateAll()) {
      return true;
    } else {
      isLogingIn.value = false;
      if (!_inputValidator.isFirstNameValid()) {
        isFirstNameError.value = true;
        Get.snackbar('Validation Error', _inputValidator.validateName()!,
            snackPosition: SnackPosition.TOP);
        return false;
      } else {
        isFirstNameError.value = false;
      }
      if (!_inputValidator.isLastNameValid()) {
        isLastNameError.value = true;
        Get.snackbar('Validation Error', _inputValidator.validateName()!,
            snackPosition: SnackPosition.TOP);
        return false;
      } else {
        isLastNameError.value = false;
      }

      if (!_inputValidator.isEmailValid()) {
        isEmailError.value = true;
        Get.snackbar('Validation Error', _inputValidator.validateEmail()!,
            snackPosition: SnackPosition.TOP);

        return false;
      } else {
        isEmailError.value = false;
      }
      if (!_inputValidator.isPasswordValid()) {
        isPasswordError.value = true;
        Get.snackbar('Validation Error', _inputValidator.validatePassword()!,
            snackPosition: SnackPosition.TOP);
        return false;
      } else {
        isPasswordError.value = false;
      }

      if (!_inputValidator.isPhoneValid()) {
        isPhoneNumberError.value = true;
        Get.snackbar('Validation Error', _inputValidator.validatePhone()!,
            snackPosition: SnackPosition.TOP);
        return false;
      } else {
        isPhoneNumberError.value = false;
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
