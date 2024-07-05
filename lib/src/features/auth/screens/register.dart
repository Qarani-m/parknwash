import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                              controller: signupController.firstNameController,
                              hintText: "John",
                              title: "First Name",
                            ),
                          ),
                            SizedBox(
                            width: 163.w,
                            child: CustomEmailTextField(
                              controller: signupController.lastNameController,
                              hintText: "Doe",
                              title: "Last Name",
                            ),
                          )
                        ],
                      ),

                      SizedBox(
                        height:15.h,
                      ),
                      CustomEmailTextField(
                        controller: signupController.emailController,
                        hintText: "example@example.com",
                        title: "Email",
                      ),
                      SizedBox(
                        height:15.h,
                      ),
                      CustomEmailTextField(
                        controller: signupController.phoneController,
                        hintText: "0712345678",
                        title: "Phone number",
                      ),
                      SizedBox(
                        height:15.h,
                      ),
                      CustomEmailTextField(
                        controller: signupController.passwordController,
                        hintText: "********",
                        title: "Password",
                      ),
                      SizedBox(
                        height:15.h,
                      ),
                      CustomEmailTextField(
                        controller: signupController.confirmPasswordController,
                        hintText: "********",
                        title: "Confirm Password",
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
                      )
                    ],
                  ),
                )

                // ElevatedButton(
                //     onPressed: loginController.loginEmailAndPassword,
                //     child: Text("Email Password")),
                // SizedBox(
                //   height: 50.h,
                // ),
                // ElevatedButton(
                //     onPressed: loginController.loginEmailAndPassword,
                //     child: Text("Google")),
                // SizedBox(
                //   height: 50.h,
                // ),
                // ElevatedButton(
                //     onPressed: () {
                //       Get.toNamed("/register");
                //     },
                //     child: Text("Register"))
              ],
            ),
          ),
        ),
      ),
    );

    // return Scaffold(
    //   body: SingleChildScrollView(
    //     child: Padding(
    //       padding: EdgeInsets.only(left: 23.w, right: 23.h, top: 100.h),
    //       child: Center(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: [
    //             Text("Register Page"),

    //             ElevatedButton(
    //                 onPressed: signupController.registerEmailAndPassword,
    //                 child: Text("Email Password")),
    //             SizedBox(
    //               height: 50.h,
    //             ),
    //             ElevatedButton(
    //                 onPressed: signupController.registerGoogle,
    //                 child: Text("Google")),
    //             SizedBox(
    //               height: 50.h,
    //             ),
    //             ElevatedButton(
    //                 onPressed: () {
    //                   Get.toNamed("/login");
    //                 },
    //                 child: Text("Login"))
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
