import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:parknwash/src/features/auth/controllers/signup_controller.dart';
import 'package:parknwash/src/features/auth/screens/login.dart';
import 'package:parknwash/src/utils/constants/colors.dart';

class Register extends StatelessWidget {
  Register({super.key});

  final SignupController signupController = Get.find<SignupController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 23.w, right: 23.h, top: 40.h),
          child: Obx(()=>Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                   Obx (()=>SizedBox(
                          child: signupController.isLogingIn.value
                              ? Center(
                                  child:
                                      LoadingAnimationWidget.staggeredDotsWave(
                                          color: AppColors.accentColor,
                                          size: 40.sp),
                                )
                              : const SizedBox()),),

                              
                Text("Register",
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 163.w,
                            child: CustomEmailTextField(
                              textEditingController: signupController.firstNameController,
                              hintText: "John",
                              title: "First Name",
                        error: signupController.isFirstNameError.value,

                            ),
                          ),
                            SizedBox(
                            width: 163.w,
                            child: CustomEmailTextField(
                              textEditingController: signupController.lastNameController,
                              hintText: "Doe",
                              title: "Last Name",
                        error: signupController.isLastNameError.value,

                            ),
                          )
                        ],
                      ),

                      SizedBox(
                        height:15.h,
                      ),
                      CustomEmailTextField(
                        textEditingController: signupController.emailController,
                        hintText: "example@example.com",
                        title: "Email",
                        error: signupController.isEmailError.value,
                      ),
                      SizedBox(
                        height:15.h,
                      ),
                      CustomEmailTextField(
                        textEditingController: signupController.phoneController,
                        hintText: "0712345678",
                        title: "Phone number",
                        error: signupController.isPhoneNumberError.value,

                      ),
                      SizedBox(
                        height:15.h,
                      ),
                      CustomEmailTextField(
                        textEditingController: signupController.passwordController,
                        hintText: "● ● ● ● ● ● ● ●",
                        title: "Password",
                        error: signupController.isPasswordError.value,
                        obscureText:true,



                      ),
                      SizedBox(
                        height:15.h,
                      ),
                      CustomEmailTextField(
                        textEditingController: signupController.confirmPasswordController,
                       
                          hintText: "● ● ● ● ● ● ● ●",

                        title: "Confirm Password",
                        error: signupController.isConfirmedPasswordError.value,
                        obscureText:false,


                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      CustomLoginButton(
                        onPressed: signupController.registerEmailAndPassword,
                        text:"Register"
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("or register with",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  )),
                        ],
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      GoogleLoginButton(
                        onPressed: signupController.registerGoogle,
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed("/login"),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account? ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    )),
                            Text("Login ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.accentColor)),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.h,)
                    ],
                  ),
                )

              ],
            ),
          ),)
        ),
      ),
    );
  }
}
