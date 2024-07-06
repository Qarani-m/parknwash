import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parknwash/src/features/auth/controllers/forgot_password_controller.dart';
import 'package:parknwash/src/features/auth/screens/login.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  final ForgotPasswordController controller =
      Get.find<ForgotPasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 23.w, right: 23.h, top: 50.h),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: ()=>Get.offNamed("/login"),
                    child: const Icon(Icons.arrow_back_ios),
                  ),
                ),
                SizedBox(height: 110.h,),
                Text("Forgot Password?",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(fontWeight: FontWeight.w700)),
                SizedBox(
                  height: 30.h,
                ),
                Text(
                    "A password reset link will be sent to your registered email address.", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),),
               
               SizedBox(
                  height: 30.h,
                ),
                Container(
                  child: Column(
                    children: [
                      CustomEmailTextField(
                        textEditingController: controller.emailController,
                        hintText: "example@example.com",
                        title: "Email",
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      CustomLoginButton(
                          onPressed: controller.sendCode, text: "Send"),
                      SizedBox(
                        height: 50.h,
                      ),
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
