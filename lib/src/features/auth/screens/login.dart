import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parknwash/src/features/auth/controllers/login_controller.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 23.w, right: 23.h, top: 100.h),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Login Page"),
                ElevatedButton(
                    onPressed: loginController.loginEmailAndPassword,
                    child: Text("Email Password")),
                SizedBox(
                  height: 50.h,
                ),
                ElevatedButton(
                    onPressed: loginController.loginEmailAndPassword,
                    child: Text("Google")),
                SizedBox(
                  height: 50.h,
                ),
                ElevatedButton(
                    onPressed: () {
                      Get.toNamed("/register");
                    },
                    child: Text("Register"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
