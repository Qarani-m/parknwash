
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parknwash/src/features/profile/controller/notifications_controller.dart';
import 'package:parknwash/src/features/profile/controller/payment_history_controller.dart';
import 'package:parknwash/src/features/profile/widgets/notifications_body.dart';

class PaymentHistory extends StatelessWidget {
  PaymentHistory({super.key});

  PaymentHistoryController controller = Get.find<PaymentHistoryController>();
    NotificationsController notificationsController = Get.find<NotificationsController>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
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
                      Text(controller.title.value),
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
                            SizedBox(height: 20.h,),
                           ...controller.payments_list.value.map((miniNotification) {
                          return NotificationsPage(
                            controller: notificationsController,
                            miniNotification: miniNotification,
                          );
                        }),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                       ]
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
