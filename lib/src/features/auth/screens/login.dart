import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parknwash/src/features/auth/controllers/login_controller.dart';
import 'package:parknwash/src/utils/constants/colors.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 23.w, right: 23.h, top: 60.h),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Login",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(fontWeight: FontWeight.w700)),
                SizedBox(
                  height: 30.h,
                ),

                Container(
                  child: Column(
                    children: [
                      CustomEmailTextField(
                        controller: loginController.emailController,
                        hintText: "example@example.com",
                        title: "Email",
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomEmailTextField(
                        controller: loginController.passwordController,
                        hintText: "********",
                        title: "Password",
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text("Forgot Password?",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.accentColor)),
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      CustomLoginButton(
                          onPressed: loginController.loginEmailAndPassword,
                          text: "Login"),
                      SizedBox(
                        height: 50.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("or login with",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  )),
                        ],
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      GoogleLoginButton(
                        onPressed: loginController.loginGoogle,
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed("/register"),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Dont have an account? ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    )),
                            Text("Register ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.accentColor)),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomEmailTextField extends StatelessWidget {
  CustomEmailTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.title})
      : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontWeight: FontWeight.w400)),
        SizedBox(
          height: 10.h,
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.only(left: 16, top: 14, bottom: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[400]!, width: 1),
            ),
          ),
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

class CustomLoginButton extends StatelessWidget {
  final VoidCallback onPressed;

   CustomLoginButton({Key? key, required this.onPressed, required this.text})
      : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.accentColor, // Dark green color
          borderRadius: BorderRadius.circular(25),
        ),
        child:  Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class GoogleLoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleLoginButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey[300]!, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              'https://www.google.com/images/branding/googleg/1x/googleg_standard_color_128dp.png',
              height: 24,
              width: 24,
            ),
            const SizedBox(width: 12),
            const Text(
              'Login with Google',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
