import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parknwash/src/utils/constants/colors.dart';


class StartBookingBottomSheet extends StatelessWidget {
  const StartBookingBottomSheet(
      {super.key,
      required this.zone,
      required this.rates,
      required this.distance});

  final String zone;
  final String rates;
  final String distance;

  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 455.h,
          padding: EdgeInsets.only(top: 10.h, left: 30.w, right: 30.w),
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
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
                  height: 20.h,
                ),
                Container(
                  padding: EdgeInsets.only(top: 15.h),
                  height: 230.h,
                  width: 320.w,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38),
                      borderRadius: BorderRadius.circular(20.sp)),
                  child: Column(
                    children: [
                      Container(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 30.h,
                                    width: 120.w,
                                    // color: Colors.red,
                                    child: Text(distance),
                                  ),
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
                              height: 90.h,
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
                                "KSH $rates/HR",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                        fontSize: 30.sp,
                                        fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 35.h,
                                // width: 120.w,
                                // color: Colors.red,
                                child: Text(
                                  "Moi Avenue, opposite Veteran House Nairobi KE, Nairobi",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
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
