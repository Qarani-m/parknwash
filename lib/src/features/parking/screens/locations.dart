import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parknwash/src/features/parking/controllers/locations.dart';
import 'package:parknwash/src/utils/constants/colors.dart';

class LocationsPage extends StatelessWidget {
  LocationsPage({super.key});

  final LocationsController controller = Get.find<LocationsController>();

  @override
  Widget build(BuildContext context) {
    String zone = "A-013";
    String rates = "40";
    return Scaffold(
      body: StartBookingBottomSheet(zone: zone, rates: rates),
    );
  }
}

class StartBookingBottomSheet extends StatelessWidget {
  const StartBookingBottomSheet({
    super.key,
    required this.zone,
    required this.rates,
  });

  final String zone;
  final String rates;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 488.h,
          padding: EdgeInsets.only(top: 25.h, left: 30.w, right: 30.w),
          width: double.maxFinite,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.r),
                  topRight: Radius.circular(15.r))),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Book your car",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Text(
                  "Parking",
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Container(
                  padding: EdgeInsets.only(top: 15.h),
                  height: 230.h,
                  width: 320.w,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(20.sp)),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 13.w, vertical: 10.h),
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            color: AppColors.blackTextColor
                                                .withOpacity(0.3),
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Text(
                                    zone,
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
                              height: 113.h,
                              width: 130.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.sp),
                                  image: const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          "assets/images/location_pointer.png"))),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 93.h,
                        width: 320.w,
                        // color: Colors.amber,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Rates",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: AppColors.blackTextColor
                                            .withOpacity(0.3),
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                "KSH $rates/HR",
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
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                GestureDetector(
                  onTap: () => Get.toNamed("/details_page", arguments: {
                    'lotId': zone, // Example parameter
                  }),
                  child: Container(
                    height: 70.h,
                    width: 320.w,
                    decoration: BoxDecoration(
                        color: AppColors.accentColor,
                        borderRadius: BorderRadius.circular(20.sp)),
                    child: const Center(
                      child: Text("Start Booking"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
