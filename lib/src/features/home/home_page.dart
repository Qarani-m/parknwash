import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:parknwash/src/common_widgets/centric_circes.dart';
import 'package:parknwash/src/features/home/controller/homecontroller.dart';
import 'package:parknwash/src/utils/constants/colors.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final List<String> categories = ["Car", "Bike", "Bus"];
  final List<String> icons = [
    "car-front-fill.svg",
    "bicycle.svg",
    "bus-front-fill.svg"
  ];

  final Homecontroller controller = Get.find<Homecontroller>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 50.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            SizedBox(height: 35.h),
            _buildGreeting(context),
            SizedBox(height: 35.h),
            _buildCategoryButtons(controller),
            _buildBottomSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 23.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 50.h,
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
          SvgPicture.asset(
            "assets/svg/geo-alt-fill.svg",
            width: 30.h,
            height: 30.h,
            color: const Color(0xFFDDD9F0),
          ),
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
            "Hello, Muhamed",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 19.sp,
                ),
          ),
          SizedBox(height: 20.h),
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

  Widget _buildCategoryButtons(Homecontroller controller) {
    return Obx(() => Container(
          width: double.maxFinite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              categories.length,
              (index) => GestureDetector(
                onTap: () => controller.changeSelectedCategory(index),
                child: Container(
                  height: 120.h,
                  width: 115.h,
                  decoration: BoxDecoration(
                    color: controller.selectedCategoryIndex.value == index
                        ? Color(0xFFffdd40)
                        : const Color(0xFF252525),
                    borderRadius: BorderRadius.circular(15.sp),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        "assets/svg/${icons[index]}",
                        color: controller.selectedCategoryIndex.value == index
                            ? controller.changeColor.value
                            : Color(0xFFcbcbcb),
                        width: 60.h,
                        height: 60.h,
                      ),
                      Text(
                        categories[index],
                        style: Get.textTheme.bodyMedium?.copyWith(
                          color: controller.selectedCategoryIndex.value == index
                              ? controller.changeColor.value
                              : Color(0xFFcbcbcb),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Widget _buildBottomSection(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: double.maxFinite,
          height: 370.h,
          padding: EdgeInsets.only(top: 10.h),
          child: const Lanes(),
        ),
        Positioned(
          top: 205.h,
          left: (MediaQuery.of(context).size.width / 2) - (153.h / 2) - 5,
          child: Container(
            width: 153.h,
            height: 153.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFffdd40),
            ),
            child: Center(
              child: Text(
                "Start\n to find parking",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.blackTextColor,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
