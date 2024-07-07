import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parknwash/src/features/profile/controller/notifications_controller.dart';
import 'package:parknwash/src/features/profile/models/mini_notification.dart';

class Notifications extends StatelessWidget {
  Notifications({super.key});

  NotificationsController controller = Get.find<NotificationsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 50.h, right: 21.w, left: 21.w),
        child: Obx(() => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(Icons.arrow_back)),
                    Text("Your Notifications "),
                    SizedBox(
                      width: 23.w,
                    )
                  ],
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                              // height: 20.h,
                              ),
                          Align(
                              alignment: Alignment.centerLeft, child: Text("")),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      ...controller.notifications.value.map((miniNotification) {
                        return 
                        Notification(
                          controller: controller,
                          miniNotification: miniNotification,
                        );
                      }).toList(),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}

class Notification extends StatelessWidget {
  Notification({
    super.key,
    required this.miniNotification, 
    required this.controller,
  });
  final MiniNotification miniNotification;
  final NotificationsController controller;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:()=> controller.showBottomSheet(
          miniNotification.type, miniNotification.id),
      child: Container(
        margin: EdgeInsets.only(bottom: 20.h),
        height: 100.h,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.sp),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(top: 5.h, left: 5.w, bottom: 5.h),
              height: 65.h,
              width: 100.w,
              decoration: BoxDecoration(
                  // color: Colors.red,

                  image: DecorationImage(
                      image: AssetImage("assets/images/money.png"))),
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10.h),
                  width: 200.w,
                  // color: Colors.lightBlue,
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        miniNotification.dateTime,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: 11.sp),
                      )),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      miniNotification.title,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    SizedBox(
                        width: 220.w,
                        child: Text(miniNotification.subtitle,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontWeight: FontWeight.w400)))
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
