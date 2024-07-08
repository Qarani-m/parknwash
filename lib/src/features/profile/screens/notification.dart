import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:parknwash/src/features/profile/controller/notifications_controller.dart';
import 'package:parknwash/src/features/profile/models/mini_notification.dart';
import 'package:parknwash/src/features/profile/models/payment_model.dart';
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

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({
    super.key,
    required this.miniNotification,
    required this.controller,
  });
  final MiniNotification miniNotification;
  final NotificationsController controller;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.showBottomSheet(
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
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(top: 5.h, left: 5.w, bottom: 5.h),
              height: 65.h,
              width: 100.w,
              decoration: const BoxDecoration(
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

class PaymentBottomSheet extends StatelessWidget {
  const PaymentBottomSheet({
    super.key,
    required this.context,
    required this.paymentModel,
  });

  final BuildContext context;
  final PaymentModel paymentModel;

  @override
  Widget build(BuildContext context) {
    print(paymentModel.createdAt);
    String formattedDate =
        DateFormat('yyyy-MM-dd').format(paymentModel.createdAt);

    final bool isExpired = paymentModel.expired;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Payment Succesful",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(
          height: 15.h,
        ),
        Text(
            textAlign: TextAlign.center,
            "Yah have Succesfull paid Ksh ${paymentModel.amount} for the parking space on ${paymentModel.lotId} Parking Lot",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w400, fontSize: 15.sp)),
        SizedBox(
          height: 25.h,
        ),
        Container(
          alignment: Alignment.center,
          width: double.maxFinite,
          height: 300.h,
          child: PrettyQrView.data(
            data: 'lorem ipsum dolor sit amet',
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        Container(
          color: isExpired ? Colors.red : Colors.green,
          padding: EdgeInsets.all(5.h),
          child: Text(
              textAlign: TextAlign.center,
              isExpired ? "Already Used" : "Still Valid",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 15.sp,
                  color: Colors.white)),
        ),
        SizedBox(
          height: 35.h,
        ),
        KeyValue(
            context: context,
            text: "Amount",
            value: "Ksh ${paymentModel.amount}"),
        SizedBox(
          height: 15.h,
        ),
        KeyValue(
            context: context,
            text: "Reference ID: ",
            value: paymentModel.referenceId),
        SizedBox(
          height: 15.h,
        ),
        KeyValue(context: context, text: "Date:", value: formattedDate),
        SizedBox(
          height: 40.h,
        ),
        GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.cancel_outlined,
            size: 55.sp,
            weight: 1.sp,
          ),
        )
      ],
    );
  }
}

class KeyValue extends StatelessWidget {
  const KeyValue({
    super.key,
    required this.context,
    required this.text,
    required this.value,
  });
  final String value;
  final String text;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("$text: ",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w400, fontSize: 15.sp)),
        Text(value,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w400, fontSize: 15.sp)),
      ],
    );
  }
}
