import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parknwash/src/features/parking/controllers/booking_finished.dart';

class BookingFinished extends StatelessWidget {
  BookingFinished({super.key});

  final BookingFinishedController controller = Get.find<BookingFinishedController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 23.w, right: 23.w, top: 50.h),
        child: const Center(
          child: Text("this page"),
        ),
      ),
    );
  }
}
