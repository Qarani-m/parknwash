import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parknwash/src/features/auth/controllers/login_controller.dart';
import 'package:parknwash/src/features/home/controller/homecontroller.dart';
import 'package:parknwash/src/features/profile/controller/profile_controller.dart';
import 'package:parknwash/src/utils/constants/colors.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final LoginController loginController =
      Get.put<LoginController>(LoginController());
  final Homecontroller homecontroller = Get.find<Homecontroller>();
  final ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    bool isLightMode = Theme.of(context).brightness == Brightness.light;

    return Obx(() => Scaffold(
          body: Padding(
            padding: EdgeInsets.only(left: 23.w, right: 23.w, top: 50.h),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(Icons.arrow_back)),
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
                      Container(
                        padding: EdgeInsets.only(top: 10.h),

                        height: 70.h,
                        width: 164.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.sp),
                                bottomLeft: Radius.circular(20.sp)),
                            border: Border.all(
                                color: !isLightMode
                                    ? AppColors.whiteTextColor.withOpacity(0.1)
                                    : AppColors.whiteTextColor)),
                        child: Column(
                          children: [
                            Text(
                              'Spent',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w300),
                            ),
                            Text(
                              'Ksh. 7892',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      color: AppColors.accentColor,
                                      fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10.h),
                        alignment: Alignment.center,
                        height: 70.h,
                        width: 164.w,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: !isLightMode
                                    ? AppColors.whiteTextColor.withOpacity(0.1)
                                    : AppColors.whiteTextColor),

                            // border: Border.all(color: AppColors.whiteTextColor),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20.sp),
                                bottomRight: Radius.circular(20.sp))),
                        child: Column(
                          children: [
                            Text(
                              'Time',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w300),
                            ),
                            Text(
                              '243 hrs',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      color: AppColors.accentColor,
                                      fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () => controller.goToPayments(),
                      child: Row(
                        children: [
                          Icon(
                            Icons.payment,
                            size: 35.h,
                            color: AppColors.accentColor,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Text(
                            "Payments",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    GestureDetector(
                      onTap: () => controller.tellYourFriends(),
                      child: Row(
                        children: [
                          Icon(
                            Icons.share,
                            size: 35.h,
                            color: AppColors.accentColor,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Text(
                            "Tell Your Friends",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    GestureDetector(
                      onTap: () => homecontroller.logout(context),
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            size: 35.h,
                            weight: 0.1,
                            color: AppColors.accentColor,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Text(
                            "Log Out",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
