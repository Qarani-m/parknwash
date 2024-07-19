import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:parknwash/src/common_widgets/centric_circes.dart';
import 'package:parknwash/src/features/home/controller/homecontroller.dart';
import 'package:parknwash/src/features/profile/controller/notifications_controller.dart';
import 'package:parknwash/src/utils/constants/colors.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<String> categories = ["Car", "Bike", "Bus"];
  final List<String> icons = [
    "car-front-fill.svg",
    "bicycle.svg",
    "bus-front-fill.svg"
  ];

  final Homecontroller controller = Get.find<Homecontroller>();
  final NotificationsController notificationsController =
      Get.find<NotificationsController>();

  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;
    final isDarkMode = theme.brightness == Brightness.dark;
    return Obx(() => Scaffold(
          body: Padding(
            padding: EdgeInsets.only(top: 50.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                SizedBox(height: 25.h),
                _buildGreeting(context),
                SizedBox(height: 25.h),
                _buildCategoryButtons(controller, context),
                _buildBottomSection(context),
              ],
            ),
          ),
          floatingActionButton: Padding(
            padding:
                EdgeInsets.only(bottom: 40.h), // Adjust the value as needed
            child: Container(
              width: 143.h,
              height: 143.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accentColor,
              ),
              child: FloatingActionButton(
                backgroundColor: AppColors.accentColor,
                shape: const CircleBorder(),
                onPressed: () {
                  controller.startParking();
                },
                child: Center(
                  child: Text(
                    "Start\n to find parking",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.blackTextColor,
                        ),
                  ),
                ),
                //params
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar(
              icons: const [Icons.local_car_wash, Icons.local_parking],
              activeIndex: controller.activeIndex.value,
              elevation: 50,
              backgroundColor:
                  isDarkMode ? AppColors.scaffoldColorDark : Colors.white,
              splashColor: Colors.red,
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.defaultEdge,
              leftCornerRadius: 2,
              rightCornerRadius: 2,
              activeColor: AppColors.accentColor,
              inactiveColor:
                  isDarkMode ? Colors.white : AppColors.scaffoldColorDark,
              gapWidth: 130,
              shadow: Shadow(
                  color: isDarkMode ? Colors.white54 : Colors.black54,
                  blurRadius: 10,
                  offset: const Offset(-2, 0)),
              onTap: (value) {
                controller.activeIndex.value = value;
                if (value == 0) {
                  print("First icon pressed");
                } else {
                  Get.toNamed("/booking_list");
                }
              }),
        ));
  }

  Widget _buildHeader(BuildContext context) {
    bool isLightMode = Theme.of(context).brightness == Brightness.light;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 23.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => controller.goToProfile(),
            child: Container(
              height: 40.h,
              width: 50.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.sp),
              ),
              child: Image.asset(
                "assets/images/man.png",
                width: 30.h,
                height: 30.h,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // LocalNotificationController.scheduleNotifications("test", "test body", 60);
              Get.toNamed('/notifications');
            },
            child: SvgPicture.asset(
              "assets/svg/bell-fill.svg",
              width: 27.h,
              height: 27.h,
              color: isLightMode ? const Color(0xFF252525) : Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGreeting(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 23.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.userName.value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 25.sp,
                fontFamily: "Kalam"),
          ),
          SizedBox(height: 15.h),
          Text(
            "We make parking",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Text(
            "Easy",
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontSize: 35.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Kalam",
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButtons(
      Homecontroller controller, BuildContext context) {
    bool isLightMode = Theme.of(context).brightness == Brightness.light;
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          categories.length,
          (index) => GestureDetector(
              onTap: () => controller.changeSelectedCategory(index),
              child: Container(
                height: 110.h,
                width: 115.h,
                decoration: BoxDecoration(
                  color: controller.selectedCategoryIndex.value == index
                      ? AppColors.accentColor
                      : isLightMode
                          ? Colors.white
                          : const Color(0xFF252525),
                  borderRadius: BorderRadius.circular(15.sp),
                  boxShadow: isLightMode
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ]
                      : [],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(
                      "assets/svg/${icons[index]}",
                      color: controller.selectedCategoryIndex.value == index
                          ? controller.changeColor.value
                          : isLightMode
                              ? Colors.black
                              : const Color(0xFFcbcbcb),
                      width: 60.h,
                      height: 60.h,
                    ),
                    Text(
                      categories[index],
                      style: Get.textTheme.bodyMedium?.copyWith(
                        color: controller.selectedCategoryIndex.value == index
                            ? controller.changeColor.value
                            : isLightMode
                                ? Colors.black
                                : const Color(0xFFcbcbcb),
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: double.maxFinite,
          height: 360.h,
          padding: EdgeInsets.only(top: 10.h),
          child: const Lanes(),
        ),
        // Positioned(
        //   top: 205.h,
        //   left: (MediaQuery.of(context).size.width / 2) - (153.h / 2) - 5,
        //   child: GestureDetector(
        //     onTap: () => controller.startParking(),
        //     child: Container(
        //       width: 153.h,
        //       height: 143.h,
        //       decoration: const BoxDecoration(
        //         shape: BoxShape.circle,
        //         color: AppColors.accentColor,
        //       ),
        //       child: Center(
        //         child: Text(
        //           "Start\n to find parking",
        //           textAlign: TextAlign.center,
        //           style: Theme.of(context).textTheme.bodyMedium?.copyWith(
        //                 color: AppColors.blackTextColor,
        //               ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
