import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:parknwash/src/features/profile/controller/notifications_controller.dart';
import 'package:parknwash/src/features/profile/models/mini_notification.dart';
import 'package:parknwash/src/features/profile/models/payment_model.dart';
import 'package:parknwash/src/features/profile/widgets/notifications_body.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

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
                    const Text("Your Notifications "),
                    SizedBox(
                      width: 23.w,
                    )
                  ],
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const Column(
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
                        return NotificationsPage(
                          controller: controller,
                          miniNotification: miniNotification,
                        );
                      }),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
