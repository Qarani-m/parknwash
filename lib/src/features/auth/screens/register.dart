import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parknwash/src/features/auth/controllers/signup_controller.dart';

class Register extends StatelessWidget {
   Register({super.key});

  final SignupController signupController = Get.find<SignupController>();

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
                Text("Register Page"),

                ElevatedButton(
                    onPressed: signupController.registerEmailAndPassword,
                    child: Text("Email Password")),
                SizedBox(
                  height: 50.h,
                ),
                ElevatedButton(
                    onPressed: signupController.registerGoogle,
                    child: Text("Google")),
                SizedBox(
                  height: 50.h,
                ),
                ElevatedButton(
                    onPressed: () {
                      Get.toNamed("/login");
                    },
                    child: Text("Login"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
