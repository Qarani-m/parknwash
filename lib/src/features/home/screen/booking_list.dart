import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parknwash/src/features/home/controller/booking_list_controller.dart';
import 'package:parknwash/src/features/home/models/booking_model.dart';
import 'package:parknwash/src/utils/constants/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BookingList extends StatelessWidget {
  BookingList({super.key});

  BookingListController controller = Get.find<BookingListController>();

  @override
  Widget build(BuildContext context) {
    // controller.getBookings(controller.extractUid());
    controller.getBookings("pSgDcrX5XtaXujizeObCw3o5CWb2");
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          top: 50.h,
          right: 23.w,
          left: 23.w,
        ),
        child: Obx(
          () => Column(
            children: [
              SizedBox(
                height: 40.h,
                width: double.maxFinite,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () => Get.offNamed("/home"),
                        child: const Icon(Icons.arrow_back)),
                    const Text("Your activity"),
                    SizedBox(
                      width: 10.w,
                    ),
                  ],
                ),
              ),






              SizedBox(height: 15.h),
              controller.bookings.value.isEmpty 
                  ?controller.stopLoading.value? Container(
                    height: 20.h,
                    width:30.w,

                    
                    child: LoadingAnimationWidget.staggeredDotsWave(color: AppColors.accentColor, size: 40.sp)) : const Text("You have no prior activity")
                  : Column(
                      children: List.generate(
                          controller.bookings.value.length,
                          (index) => ParkingHistoryCard(
                              bookingData: controller.bookings.value[index])),
                    ),
            ],
          ),
        ),
      ),
    ));
  }
}

class ParkingHistoryCard extends StatelessWidget {
  const ParkingHistoryCard({super.key, required this.bookingData});

  final BookingData bookingData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          "/my_bookings",
          arguments: {
            'booking': bookingData,
            "price": bookingData.timeDifference["price"] ?? ""
          },
        );
      },
      child: LIstCard(bookingData: bookingData),
    );
  }
}

class LIstCard extends StatelessWidget {
  const LIstCard({
    super.key,
    required this.bookingData,
  });

  final BookingData bookingData;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Get.theme.scaffoldBackgroundColor,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: bookingData.status == "Completed"
                            ? const Color(0xFF24a0e1).withOpacity(0.1)
                            : bookingData.status == "Pending"
                                ? AppColors.accentColor.withOpacity(0.1)
                                : bookingData.status == "Cancelled"
                                    ? const Color(0xFFDC143c).withOpacity(0.1)
                                    : const Color(0xFF39C16B).withOpacity(0.1),
          width: 2.0, // Border width
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Date section
                Column(
                  children: [
                    Text(
                      bookingData.timestamp['date']?.split("-")[2] ?? "",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      bookingData.timestamp['date']
                              ?.split("-")[1]
                              .capitalize ??
                          "",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      bookingData.timestamp['date']?.split("-")[0] ?? "",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                // Status indicator
                Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: bookingData.status == "Completed"
                            ? const Color(0xFF24a0e1)
                            : bookingData.status == "Pending"
                                ? AppColors.accentColor
                                : bookingData.status == "Cancelled"
                                    ? const Color(0xFFDC143c)
                                    : const Color(0xFF39C16B),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      bookingData.status,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: bookingData.status == "Completed"
                                ? const Color(0xFF24a0e1)
                                : bookingData.status == "Pending"
                                    ? AppColors.accentColor
                                    : bookingData.status == "Cancelled"
                                        ? const Color(0xFFDC143c)
                                        : const Color(0xFF39C16B),
                          ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Parking details
            Text(
              bookingData.realName,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              bookingData.name,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            // Duration and cost
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.access_time,
                        size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      bookingData.timeDifference["difference"] ?? "",
                      style: TextStyle(color: Colors.grey[700]),
                    )
                  ],
                ),
                Text(
                  'Ksh ${bookingData.timeDifference["price"] ?? ""}',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Entry and exit times
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_today,
                        size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text('Entered: ${bookingData.timestamp["time"]}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
