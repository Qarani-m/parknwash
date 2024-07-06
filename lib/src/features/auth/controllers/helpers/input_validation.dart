import 'package:flutter/material.dart';

class InputValidator {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final TextEditingController firstNameController;
  final TextEditingController confirmPasswordController;

  InputValidator({
    required this.emailController,
    required this.passwordController,
    required this.lastNameController,
    required this.firstNameController,
    required this.confirmPasswordController,
    required this.phoneController,
  });

  bool isEmailValid() {
    final email = emailController.text.trim();
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  bool isPasswordValid() {
    final password = passwordController.text.trim();
    return password.length >= 8;
  }

  bool isFirstNameValid() {
    final name = firstNameController.text.trim();
    return name.isNotEmpty && name.length >= 3;
  }

  bool isLastNameValid() {
    final name = lastNameController.text.trim();
    return name.isNotEmpty && name.length >= 3;
  }

  bool isPhoneValid() {
    final phone = phoneController.text.trim();
    final phoneRegex = RegExp(r'^\d{9,}$');
    return phoneRegex.hasMatch(phone);
  }

  String? validateEmail() {
    return isEmailValid() ? null : 'Invalid email address';
  }

  String? validatePassword() {
    return isPasswordValid() ? null : 'Password must be at least 8 characters';
  }

  String? validateName() {
    return isFirstNameValid() && isLastNameValid()
        ? null
        : 'Name must be at least 2 characters';
  }

  String? validatePhone() {
    return isPhoneValid() ? null : 'Invalid phone number';
  }

  bool validateAll() {
    return isEmailValid() &&
        isPasswordValid() &&
        isLastNameValid() &&
        isFirstNameValid() &&
        isPhoneValid();
  }
}
