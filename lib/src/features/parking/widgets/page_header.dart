import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parknwash/src/features/parking/controllers/booking_finished_controller.dart';
import 'package:parknwash/src/features/parking/controllers/locations_controller.dart';
import 'package:parknwash/src/utils/constants/colors.dart';
import 'package:shimmer/shimmer.dart';

class PageHeader extends StatelessWidget {
  PageHeader({
    super.key,
    required this.controller,
    this.showQrCode = false,
  });
  final LocationsController controller;
  BookingFinishedController bookingFinishedController =
      Get.find<BookingFinishedController>();
  final bool showQrCode;

  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;
    final isDarkMode = theme.brightness == Brightness.dark;
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.only(top: 40.h),
        padding: EdgeInsets.only(left: 13.w, right: 13.w),
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
                        : AppColors.scaffoldColorDark,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 60.w,
            ),
            showQrCode
                ? GestureDetector(
                    onTap: () => bookingFinishedController.showBottomSheet(
                        "bookings", "cieeBOi2vPEgBLyQFOHX"),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.w,
                      width: 50.w,
                      padding: EdgeInsets.only(left: 1.w),
                      decoration: BoxDecoration(
                          color: theme.scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(10.sp)),
                      child: Center(
                        child: Shimmer.fromColors(
                          baseColor: isDarkMode
                              ? Colors.white
                              : AppColors.scaffoldColorDark,
                          highlightColor: Colors.yellow,
                          child: Icon(
                            Icons.qr_code,
                            color: isDarkMode
                                ? Colors.white
                                : theme.scaffoldBackgroundColor,
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class Pointers extends StatelessWidget {
  Pointers({
    super.key,
    required this.color,
    required this.category,
  });

  final String color;
  final String category;

  LocationsController controller = Get.find<LocationsController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.sortPoints(color),
      child: Row(
        children: [
          Container(
            height: 30.h,
            width: 30.h,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/$color.png"))),
          ),
          Text(
            category,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }
}
