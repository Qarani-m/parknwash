import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parknwash/src/features/auth/controllers/forgot_password_controller.dart';
import 'package:parknwash/src/features/auth/controllers/login_controller.dart';
import 'package:parknwash/src/features/home/controller/homecontroller.dart';
import 'package:parknwash/src/features/profile/controller/payment_history_controller.dart';
import 'package:parknwash/src/features/profile/controller/profile_controller.dart';
import 'package:parknwash/src/features/profile/widgets/profile_list_item.dart';
import 'package:parknwash/src/utils/constants/colors.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final LoginController loginController =
      Get.put<LoginController>(LoginController());
  final Homecontroller homecontroller = Get.find<Homecontroller>();
  final PaymentHistoryController paymentHistoryController =
      Get.find<PaymentHistoryController>();
  final ProfileController controller = Get.find<ProfileController>();
  final ForgotPasswordController forgotPasswordController =
      Get.find<ForgotPasswordController>();

  @override
  Widget build(BuildContext context) {
    bool isLightMode = Theme.of(context).brightness == Brightness.light;

    return Obx(() => Scaffold(
          body: Padding(
            padding: EdgeInsets.only(left: 23.w, right: 23.w, top: 50.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(Icons.arrow_back)),
                    const Text("Your Profile "),
                    SizedBox(
                      width: 23.w,
                    )
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                SizedBox(
                  height: 141.h,
                  width: double.maxFinite,
                  // color: Colors.red,
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () => controller.changeProfilePic(),
                          child: Image.asset("assets/images/man.png")),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.displayName.value,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                    fontSize: 27.sp,
                                    color: AppColors.accentColor,
                                    fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            controller.email.value,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            'Since ${controller.createdAt.value}',
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w400),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  height: 100.h,
                  width: double.maxFinite,
                  child: Row(
                    children: [
                      TimeSpent(isLightMode: isLightMode, title: 'Spent', value: "Ksh 7892",),
                      TimeSpent(isLightMode: isLightMode, title: 'Time', value: "243 hrs",),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Column(
                  children: [
                    ProfileListItem(
                      text: "Favourite Lots",
                      icon: Icons.favorite,
                      function: () => Get.toNamed("/favourite-lots"),
                    ),
                    ProfileListItem(
                        text: "Payment History",
                        icon: Icons.payment,
                        function: () => Get.toNamed("/payments-history")),
                    ProfileListItem(
                      text: "Tell Your Friends",
                      icon: Icons.share,
                      function: () => controller.tellYourFriends(),
                    ),
                    ProfileListItem(
                      text: "Change Password",
                      icon: Icons.password,
                      function: () => forgotPasswordController
                          .resetPassword(controller.email.value),
                    ),
                    ProfileListItem(
                      text: "Log Out",
                      icon: Icons.logout,
                      function: () => homecontroller.logout(context),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}