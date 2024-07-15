import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parknwash/src/features/home/controller/booking_list_controller.dart';
import 'package:parknwash/src/features/home/models/booking_model.dart';
import 'package:parknwash/src/features/profile/models/lot_model.dart';
import 'package:parknwash/src/utils/constants/colors.dart';

class BookingList extends StatelessWidget {
  BookingList({super.key});

  BookingListController controller = Get.find<BookingListController>();

  @override
  Widget build(BuildContext context) {
    // controller.getBookings(controller.extractUid());
    controller. getBookings("pSgDcrX5XtaXujizeObCw3o5CWb2");
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 50.h,
            right: 23.w,
            left: 23.w,
          ),
          child: Obx(() =>  Column(
            children: [
              Container(
                height: 40.h,
                width: double.maxFinite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () => Get.back(), child: Icon(Icons.arrow_back)),
                    Text("Your activity"),
                    SizedBox(
                      width: 10.w,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.h),
              controller.bookings.value.length < 1
                  ? Text("You have no prior activity")
                  : Column(
                      children: List.generate(
                          controller.bookings.value.length,
                          (index) =>
                              Activity(lot: controller.bookings.value[index])),
                    ),
            ],
          ),
        ),
      ),)
    );
  }
}

class Activity extends StatelessWidget {
  const Activity({
    super.key,
    required this.lot,
  });

  final BookingData lot;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Get.toNamed("/my_bookings", arguments: lot),
          child: Container(
            height: 100.h,
            width: double.maxFinite,
            decoration: const BoxDecoration(

                // color: Colors.red

                ),
            child: Row(
              children: [
                Container(
                  height: 100.h,
                  width: 120.w,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            "assets/images/download.jpeg",
                          )),
                      borderRadius: BorderRadius.circular(15.sp)),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${lot.lotId.substring(0, 5).toUpperCase()}"),
                    SizedBox(
                      width: 190.w,
                      child: Text(
                        lot.name,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 17.sp, fontWeight: FontWeight.w300),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 2.sp, horizontal: 7.sp),
                      decoration: BoxDecoration(
                          color: lot.status == "Pending"
                              ? Colors.amber
                              : lot.status == "Inprogress"
                                  ? Colors.green
                                  : Color(0xFFDC143C),
                          borderRadius: BorderRadius.circular(10.sp)),
                      child: Text(
                        lot.status,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w300,
                            color: Colors.white),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20.h,
        )
      ],
    );
  }
}
