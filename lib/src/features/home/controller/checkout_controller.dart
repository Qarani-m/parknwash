import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:parknwash/src/features/home/models/booking_model.dart';
import 'package:parknwash/src/utils/constants/colors.dart';

class CheckoutController extends GetxController {
  RxString time = "98".obs;
  RxString location = "Downtown Lot".obs;
  RxDouble rates = 50.0.obs;
  RxString mobile = "0704847676".obs;

  RxString total = "0".obs;

  TextEditingController phoneController = TextEditingController();
  final box = GetStorage();

  @override
  void onInit() {
    phoneController.text = "0704847676";

    total.value = (int.parse(time.value) * rates.value).toString();
    super.onInit();
  }

void sendRequest() {


  Get.offAllNamed("/my_bookings", arguments: {

    // "booking":BookingData(
    //   timeDifference: timeDifference, 
    //   documentId: documentId, 
    //   cat: cat, 
    //   eta: eta, 
    //   lotId: lotId, 
    //   phone: phone, 
    //   status: status, 
    //   timestamp: 
    //   timestamp, 
    //   userId: userId, 
    //   vehicleRegNo: 
    //   vehicleRegNo, 
    //   name: name, 
    //   realName: realName)

  });





  // Get.bottomSheet(
  //   BootomSheet(),
  //   isDismissible: false,  // Prevent user from dismissing the sheet
  // );

  // // Wait for 1 minute, then close the bottom sheet and show error
  // Future.delayed(Duration(seconds: 3), () {
  //   // Close the bottom sheet
  //   Get.back();

  //   // Show error message
  //   Get.snackbar(
  //     'Error',
  //     'Something went wrong',
  //     snackPosition: SnackPosition.TOP,
  //     backgroundColor: Colors.red,
  //     colorText: Colors.white,
  //     duration: Duration(seconds: 3),
  //   );
  // });
}
}

class BootomSheet extends StatelessWidget {
  const BootomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.sp),
            topRight: Radius.circular(20.sp),
          )),
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            height: 50.h,
            width: double.maxFinite,
            child: Text(
              "PLease wait while we process your payment",
              style: Theme.of(Get.context!)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Container(
            height: 50.h,
            width: 60.w,
            child: LoadingAnimationWidget.staggeredDotsWave(
                color: AppColors.accentColor, size: 40.w),
          )
        ],
      ),
    );
  }
}
