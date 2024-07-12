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
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.only(top: 40.h),
        padding: EdgeInsets.only(left: 13.w, right: 23.w),
        // color: Colors.red,
        width: double.maxFinite, // Set your desired width
        height: 40,
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                alignment: Alignment.center,
                height: 50.w,
                width: 50.w,
                padding: EdgeInsets.only(left: 7.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.sp)),
                child: const Center(
                  child: Icon(Icons.arrow_back_ios),
                ),
              ),
            ),
            SizedBox(
              width: 60.w,
            ),
            Center(
              child: Text(
                "",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}