import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:parknwash/src/features/home/controller/my_booking_controller.dart';
import 'package:parknwash/src/features/home/models/booking_model.dart';
import 'package:parknwash/src/utils/constants/colors.dart';
import 'package:shimmer/shimmer.dart';

class MyBookings extends StatelessWidget {
  MyBookings({super.key});

  MyBookingController controller = Get.find<MyBookingController>();
  final BookingData booking = Get.arguments as BookingData;

  @override
  Widget build(BuildContext context) {
    print(booking.name);
    controller.changeParkingStatus(booking.status);
    final theme = Get.theme;
    final isDarkMode = theme.brightness == Brightness.dark;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 40.h, left: 23.w, right: 23.w),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                      )),
                  controller.parkingStatus.value == "Completed"
                      ? Container(
                          height: 50.h,
                          width: 70.h,
                          child: Shimmer.fromColors(
                            baseColor: isDarkMode
                                ? Colors.white
                                : AppColors.scaffoldColorDark,
                            highlightColor: Colors.yellow,
                            child: Icon(
                              Icons.qr_code,
                              size: 30.h,
                              color: isDarkMode
                                  ? Colors.white
                                  : theme.scaffoldBackgroundColor,
                            ),
                          ),
                        )
                      : SizedBox()
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Obx(() => SingleChildScrollView(
                child: controller.isLoading.value
                    ? Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                            color: AppColors.accentColor, size: 40.h),
                      )
                    : Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 35.h,
                            width: double.maxFinite,
                            child: Text(
                              booking.vehicleRegNo,
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(fontWeight: FontWeight.w800),
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 30.h,
                            width: double.maxFinite,
                            child: Text(
                              booking.name,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Color(0xFF929292)),
                            ),
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          Container(
                            height: 20.h,
                            width: double.maxFinite,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Price: ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: Color(0xFF929292)),
                                ),
                                Text(
                                  "\$20",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                            height: 25.h,
                            width: double.maxFinite,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  controller.parkingStatus.value,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color:
                                              controller.parkingStatus.value ==
                                                      "Pending"
                                                  ? Colors.amber
                                                  : controller.parkingStatus
                                                              .value ==
                                                          "Inprogress"
                                                      ? Color(0xFF39C16B)
                                                      : Color(0xFFdc143c),
                                          fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            height: 212.h,
                            width: 212.h,
                            padding: EdgeInsets.all(20.h),
                            decoration: BoxDecoration(
                              color: controller.parkingStatus.value == "Pending"
                                  ? Colors.amber
                                  : controller.parkingStatus.value ==
                                          "Inprogress"
                                      ? Color(0xFF39C16B)
                                      : Color(0xFFdc143c),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: isDarkMode
                                      ? Colors.white38
                                      : Colors.black.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Container(
                              height: 170.h,
                              padding: EdgeInsets.symmetric(
                                  vertical: 40.h, horizontal: 20.h),
                              width: 170.h,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black26),
                                color: Get.theme.scaffoldBackgroundColor,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: isDarkMode
                                        ? Colors.white38
                                        : Colors.black.withOpacity(0.3),
                                    spreadRadius: -3,
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Transform.rotate(
                                angle: -90 * pi / 180, // 90 degrees in radians
                                child: Container(
                                  height: 170.h,
                                  width: 170.h,
                                  decoration: BoxDecoration(
                                    // color: Colors.blue,
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/images/vehicle.png"),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          Container(
                            height: 58.h,
                            width: double.maxFinite,
                            // color: Colors.red,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.bottomRight,
                                  height: 58.h,
                                  width: 230.w,
                                  // color: Colors.amber,
                                  child: Text(
                                    "00 : 00",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            fontSize: 45.sp,
                                            fontWeight: FontWeight.w900),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  height: 58.h,
                                  width: 90.w,
                                  child: Text(
                                    "min",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: Color(0xFF929292)),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 25.h,
                            width: double.maxFinite,
                            child: Text(
                              "12:10 pm  15 july 2024",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Color(0xFF929292)),
                            ),
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black38),
                                borderRadius: BorderRadius.circular(20.sp)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 13.w, vertical: 5.h),
                            height: 114.h,
                            width: 320.w,
                            // color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 100.h,
                                  width: 150.w,
                                  // color: Colors.pink,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Zone",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                color: isDarkMode
                                                    ? Colors.white
                                                        .withOpacity(0.3)
                                                    : AppColors
                                                        .scaffoldColorDark
                                                        .withOpacity(0.3),
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Text(
                                        "A-13",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium
                                            ?.copyWith(
                                                fontSize: 30.sp,
                                                fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 90.h,
                                  width: 130.w,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(10.sp),
                                      image: const DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              "assets/images/location_pointer.png"))),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          controller.parkingStatus.value == "Pending"
                              ? GestureDetector(
                                  onTap: () => controller.theButton(
                                      controller.parkingStatus.value),
                                  child: _buildButtonContainer(
                                      controller.parkingStatus.value),
                                )
                              : controller.parkingStatus.value == "Inprogress"
                                  ? _buildButtonContainer(
                                      controller.parkingStatus.value)
                                  : SizedBox()
                        ],
                      )))
          ],
        ),
      ),
    );
  }

  String _getButtonText(String status) {
    switch (status) {
      case "Pending":
        return "Check In";
      case "Inprogress":
        return "End Parking";
      default:
        return "View Financials";
    }
  }

  Widget _buildButtonContainer(String status) {
    return status == "Pending"
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.center,
                height: 70.h,
                width: 180.w,
                decoration: BoxDecoration(
                  color: AppColors.accentColor,
                  borderRadius: BorderRadius.circular(20.sp),
                ),
                child: Text(_getButtonText(status)),
              ),
              GestureDetector(
                onTap: () => controller.cancelBooking(),
                child: Container(
                  alignment: Alignment.center,
                  height: 70.h,
                  width: 130.w,
                  decoration: BoxDecoration(
                    color: Color(0xFF39C16B),
                    borderRadius: BorderRadius.circular(20.sp),
                  ),
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          )
        : Container(
            alignment: Alignment.center,
            height: 70.h,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: AppColors.accentColor,
              borderRadius: BorderRadius.circular(20.sp),
            ),
            child: Text(
              _getButtonText(status),
            ),
          );
  }
}
