import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:parknwash/src/features/parking/widgets/booking_bottomsheet.dart';
import 'package:parknwash/src/features/profile/models/payment_model.dart';
import 'package:parknwash/src/utils/constants/colors.dart';

class BookingFinishedController extends GetxController {
  final box = GetStorage();

  void showBottomSheet(String type, String id) {
    Get.bottomSheet(
      paymentBottomSheet(type, id),
      isScrollControlled:
          true, // Allows the bottom sheet to take up the full height
    );
  }

  Widget paymentBottomSheet(String type, String id) {
        final theme = Get.theme;
    final isDarkMode = theme.brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.only(top: 20.h, left: 23.w, right: 23.w),
      width: double.maxFinite,
      height: 750.h,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.sp),
          topRight: Radius.circular(20.sp),
        ),
      ),
      child: FutureBuilder<DocumentSnapshot>(
        future: fetchData(type, id),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
              color: AppColors.accentColor,
              size: 50.h,
            ));
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('No data found'));
          }

          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          print(data);
          PaymentModel payment = PaymentModel.fromMap(data);
          return BookingBottomsheet(
              context: Get.context!, paymentModel: payment);
        },
      ),
    );
  }

  Future<DocumentSnapshot> fetchData(String type, String id) async {
    return await FirebaseFirestore.instance.collection(type).doc(id).get();
  }
}
