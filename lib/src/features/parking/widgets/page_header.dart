import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parknwash/src/features/parking/controllers/locations_controller.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key,
    required this.controller,
  });

  final LocationsController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;
    final isDarkMode = theme.brightness == Brightness.dark;
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.only(top: 40.h),
        padding: EdgeInsets.only(left: 13.w, right: 0.w),
        // color: Colors.red,
        width: double.maxFinite, // Set your desired width
        height: 150,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                alignment: Alignment.center,
                height: 50.w,
                width: 50.w,
                padding: EdgeInsets.only(left: 7.w),
                decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(10.sp)),
                child: Center(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: isDarkMode
                        ? Colors.white
                        : theme.scaffoldBackgroundColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 60.w,
            ),
            Container(
              alignment: Alignment.center,
              // height: 200.w,
              width: 80.w,
              padding: EdgeInsets.only(left: 7.w, top: 15.h, bottom: 15.h),
              // color: Colors.blue,
              decoration: BoxDecoration(
                color: Get.theme.scaffoldBackgroundColor.withOpacity(0.6),
                borderRadius:BorderRadius.only(
                  topLeft: Radius.circular(10.sp),
                  bottomLeft: Radius.circular(10.sp),
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Pointers(color: "blue", category: "You",),
                  Pointers(color: "red", category: "Paid",),
                  Pointers(color: "green", category: "Free",),
                  // Pointers(color: "yellow", category: "Car Wash",),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Pointers extends StatelessWidget {
  const Pointers({
    super.key, required this.color, required this.category,
  });

  final String color;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 30.h,
          width: 30.h,
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage("assets/images/$color.png"))),
        ),
        Text(
          category,
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(fontWeight: FontWeight.w300),
        )
      ],
    );
  }
}
