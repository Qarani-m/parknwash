import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parknwash/src/features/auth/screens/login.dart';
import 'package:parknwash/src/features/parking/controllers/locations_controller.dart';
import 'package:parknwash/src/utils/constants/colors.dart';

class ParkingDetails extends StatelessWidget {
  ParkingDetails({super.key});

  final LocationsController controller = Get.find<LocationsController>();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 23.w, right: 23.w),
          child: Padding(
            padding: EdgeInsets.only(top: 50.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                      onTap: () => Get.back(),
                      child: const Icon(Icons.arrow_back_ios)),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Align(
                    alignment: Alignment.center,
                    child: Text(
                      textAlign: TextAlign.center,
                      "Please fill in your  details",
                      style: Theme.of(context).textTheme.displayMedium,
                    )),
                SizedBox(
                  height: 40.h,
                ),
                SizedBox(
                  height: 80.h,
                  width: double.maxFinite,
                  child: CustomEmailTextField(
                    textEditingController: controller.vehicleRegController,
                    hintText: 'KCD 899C',
                    title: 'Vehicle\'s Plate Number',
                  ),
                ),
                SizedBox(
                  height: 35.h,
                ),
                Text(
                  "Your estimated time with us",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 80.h,
                      width: 100.w,
                      child: CustomEmailTextField(
                        centerText: true,
                        textEditingController: controller.hrsController,
                        hintText: '00',
                        title: 'Hours',
                      ),
                    ),
                    SizedBox(
                      height: 80.h,
                      width: 100.w,
                      child: CustomEmailTextField(
                        centerText: true,
                        textEditingController: controller.minutesController,
                        hintText: '00',
                        title: 'Minutes',
                      ),
                    ),
                    SizedBox(
                      height: 80.h,
                      width: 100.w,
                      child: CustomEmailTextField(
                        textEditingController: controller.secsController,
                        centerText: true,
                        hintText: '00',
                        title: 'Seconds',
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 35.h,
                ),
                SizedBox(
                  height: 80.h,
                  width: double.maxFinite,
                  child: CustomEmailTextField(
                    textEditingController: controller.phoneController,
                    hintText: '0704847676',
                    title: 'Mpesa Phone Number',
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                GestureDetector(
                  onTap: () => Get.offNamed("/booking_finished"),
                  child: Container(
                    height: 70.h,
                    width: 320.w,
                    decoration: BoxDecoration(
                        color: AppColors.accentColor,
                        borderRadius: BorderRadius.circular(20.sp)),
                    child: const Center(
                      child: Text("Finalize Booking"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
