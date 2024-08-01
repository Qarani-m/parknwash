import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:parknwash/src/features/home/controller/checkout_controller.dart';
import 'package:parknwash/src/features/home/controller/my_booking_controller.dart';
import 'package:parknwash/src/features/home/models/booking_model.dart';
import 'package:parknwash/src/utils/constants/colors.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyBookings extends StatelessWidget {
  MyBookings({super.key});

  MyBookingController controller = Get.find<MyBookingController>();
  CheckoutController checkoutController = Get.find<CheckoutController>();

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map;
    final BookingData booking = arguments['booking'] as BookingData;
    final String completedPrice = arguments['price'];
    controller.startTimer(booking.status);
    controller.changeParkingStatus(booking.status);
    final theme = Get.theme;
    final isDarkMode = theme.brightness == Brightness.dark;

    controller.timeCounter(booking.timeDifference["difference"] ?? "");

    controller.getWhenParkingStarted(
        booking.documentId, booking.cat, booking.status);
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    checkoutController.paymentsDocId.value = "base_id";

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 40.h, left: 23.w, right: 23.w),
          child: Obx(
            () => Column(
              children: [
                QrCodeHeader(
                    isDarkMode: isDarkMode, controller: controller, theme: theme),
                StreamBuilder<DocumentSnapshot>(
                    stream: firestore
                        .collection('payments')
                        .doc(checkoutController.paymentsDocId.value)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
        
                      if (!snapshot.hasData) {
                        return const Center(child: Text('Document does not exist'));
                      }
                      Map<String, dynamic> data =
                          snapshot.data?.data() as Map<String, dynamic>;
        
                      if (data["status"] == "completed") {
                        controller.parkingStatus.value = "Completed";
                        checkoutController.updateStuff(
                            booking.documentId, snapshot.data!.id);
                      }
                      String payStatus = " ";
                      return Obx(()=> SingleChildScrollView(
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
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w800),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height: 45.h,
                                        width: double.maxFinite,
                                        child: Text(
                                          booking.name,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  color: const Color(0xFF929292)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                        width: double.maxFinite,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Price: ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      color:
                                                          const Color(0xFF929292)),
                                            ),
                                            Text(
                                              booking.status == "Completed"
                                                  ? completedPrice
                                                  : "Ksh ${controller.price.value.toStringAsFixed(2)}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      SizedBox(
                                        height: 25.h,
                                        width: double.maxFinite,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${controller.parkingStatus.value}, $payStatus",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      color: controller
                                                                  .parkingStatus
                                                                  .value ==
                                                              "Pending"
                                                          ? Colors.amber
                                                          : controller.parkingStatus
                                                                      .value ==
                                                                  "Inprogress"
                                                              ? const Color(
                                                                  0xFF39C16B)
                                                              : controller.parkingStatus
                                                                          .value ==
                                                                      "Cancelled"
                                                                  ? const Color(
                                                                      0xFFDC143c)
                                                                  : const Color(
                                                                      0xFF24a0e1),
                                                      fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      RoundAbout(
                                          controller: controller,
                                          isDarkMode: isDarkMode),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      TimeCounter(
                                          booking: booking, controller: controller),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height: 25.h,
                                        width: double.maxFinite,
                                        child: Text(
                                          " ${booking.timestamp['time'] ?? ""} ${booking.timestamp['date'] ?? ""}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  color: const Color(0xFF929292)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      _zoneHolder(context, isDarkMode),
                                      SizedBox(
                                        height: 25.h,
                                      ),
                                      controller.parkingStatus.value == "Pending"
                                          ? GestureDetector(
                                              onTap: () => controller.checkIn(
                                                booking.documentId,
                                              ),
                                              child: _buildButtonContainer(
                                                controller.parkingStatus.value,
                                                booking.documentId,
                                                booking,
                                              ),
                                            )
                                          : controller.parkingStatus.value ==
                                                  "Inprogress"
                                              ? _buildButtonContainer(
                                                  controller.parkingStatus.value,
                                                  booking.documentId,
                                                  booking,
                                                )
                                              : const SizedBox()
                                    ],
                                  )),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _zoneHolder(BuildContext context, bool isDarkMode) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black38),
          borderRadius: BorderRadius.circular(20.sp)),
      padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 5.h),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Zone",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isDarkMode
                          ? Colors.white.withOpacity(0.3)
                          : AppColors.scaffoldColorDark.withOpacity(0.3),
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
                      ?.copyWith(fontSize: 30.sp, fontWeight: FontWeight.w600),
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
                borderRadius: BorderRadius.circular(10.sp),
                image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/location_pointer.png"))),
          )
        ],
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

  Widget _buildButtonContainer(
      String status, String documentId, BookingData booking) {
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
                child: Text(
                  _getButtonText(status),
                  style: const TextStyle(color: AppColors.scaffoldColorDark),
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.parkingStatus.value = "Cancelled";
                  controller.cancelBooking(documentId);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 70.h,
                  width: 130.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF39C16B),
                    borderRadius: BorderRadius.circular(20.sp),
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => controller.endParking(booking),
                child: Container(
                  alignment: Alignment.center,
                  height: 70.h,
                  width: 180.w,
                  decoration: BoxDecoration(
                    color: AppColors.accentColor,
                    borderRadius: BorderRadius.circular(20.sp),
                  ),
                  child: Text(
                    _getButtonText(status),
                    style: const TextStyle(color: AppColors.scaffoldColorDark),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => controller.navigation(booking.lotId),
                child: Container(
                  alignment: Alignment.center,
                  height: 70.h,
                  width: 130.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF39C16B),
                    borderRadius: BorderRadius.circular(20.sp),
                  ),
                  child: const Text(
                    "Navigation",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          );
  }
}

class TimeCounter extends StatelessWidget {
  const TimeCounter({
    super.key,
    required this.booking,
    required this.controller,
  });

  final BookingData booking;
  final MyBookingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      width: double.maxFinite,
      // color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.bottomRight,
            height: 53.h,
            width: 230.w,
            // color: Colors.amber,
            child: booking.status == "Pending"
                ? Text(
                    "00 : 00",
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontSize: 45.sp, fontWeight: FontWeight.w900),
                  )
                : booking.status == "Completed"
                    ? Text(
                        controller.timeCounter(
                            booking.timeDifference["difference"] ?? ""),
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(
                                fontSize: 45.sp, fontWeight: FontWeight.w900),
                      )
                    : Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: controller.hours.value
                                  .toString()
                                  .padLeft(2, '0'),
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(
                                      fontSize: 45.sp,
                                      fontWeight: FontWeight.w900),
                            ),
                            TextSpan(
                              text: " hrs",
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(
                                      fontSize: 30.sp, // Smaller font size
                                      fontWeight: FontWeight
                                          .w400), // Lighter font weight
                            ),
                            TextSpan(
                              text: " : ",
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(
                                      fontSize: 45.sp,
                                      fontWeight: FontWeight.w900),
                            ),
                            TextSpan(
                              text: controller.minutes.value
                                  .toString()
                                  .padLeft(2, '0'),
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(
                                      fontSize: 45.sp,
                                      fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(
                                fontSize: 45.sp, fontWeight: FontWeight.w900),
                      ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            height: 48.h,
            width: 90.w,
            child: Text(
              "min",
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontSize: 30.sp, // Smaller font size
                  fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }
}

class RoundAbout extends StatelessWidget {
  const RoundAbout({
    super.key,
    required this.controller,
    required this.isDarkMode,
  });

  final MyBookingController controller;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    print(controller.parkingStatus.value);
    return Container(
      height: 212.h,
      width: 212.h,
      padding: EdgeInsets.all(20.h),
      decoration: BoxDecoration(
        color: controller.parkingStatus.value == "Pending"
            ? Colors.amber
            : controller.parkingStatus.value == "Inprogress"
                ? const Color(0xFF39C16B)
                : controller.parkingStatus.value == "Cancelled"
                    ? const Color(0xFFDC143c)
                    : const Color(0xFF24a0e1),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? Colors.white38 : Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Container(
        height: 170.h,
        padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.h),
        width: 170.h,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
          color: Get.theme.scaffoldBackgroundColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color:
                  isDarkMode ? Colors.white38 : Colors.black.withOpacity(0.3),
              spreadRadius: -3,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Transform.rotate(
          angle: -90 * pi / 180, // 90 degrees in radians
          child: Container(
            height: 170.h,
            width: 170.h,
            decoration: const BoxDecoration(
              // color: Colors.blue,
              image: DecorationImage(
                image: AssetImage("assets/images/vehicle.png"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class QrCodeHeader extends StatelessWidget {
  const QrCodeHeader({
    super.key,
    required this.isDarkMode,
    required this.controller,
    required this.theme,
  });

  final bool isDarkMode;
  final MyBookingController controller;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () {
                Get.offNamed("/booking_list");
              },
              child: const Icon(
                Icons.arrow_back,
              )),
          controller.parkingStatus.value == "Cancelled"
              ? SizedBox(
                  height: 50.h,
                )
              : GestureDetector(
                  onTap: () =>
                      controller.qrCodeTapped(controller.parkingStatus.value),
                  child: Container(
                    alignment: Alignment.centerRight,
                    height: 50.h,
                    width: 70.h,
                    child: Shimmer.fromColors(
                      baseColor: isDarkMode
                          ? Colors.white
                          : AppColors.scaffoldColorDark,
                      highlightColor: controller.parkingStatus.value ==
                              "Pending"
                          ? Colors.amber
                          : controller.parkingStatus.value == "Completed"
                              ? const Color(0xFF24a0e1).withOpacity(0.1)
                              : controller.parkingStatus.value == "Pending"
                                  ? AppColors.accentColor.withOpacity(0.1)
                                  : controller.parkingStatus.value ==
                                          "Cancelled"
                                      ? const Color(0xFFDC143c).withOpacity(0.1)
                                      : const Color(0xFF39C16B)
                                          .withOpacity(0.1),
                      child: Icon(
                        Icons.qr_code,
                        size: 30.h,
                        color: isDarkMode
                            ? Colors.white
                            : theme.scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
