import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:parknwash/src/features/profile/models/mini_notification.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class NotificationsController extends GetxController {
  RxList<MiniNotification> notifications = <MiniNotification>[].obs;

  @override
  void onInit() {
    super.onInit();
    saveNotifications(notifications_1);
    notifications.value = getNotifications();
  }

  void saveNotifications(List<MiniNotification> notifications) {
    final box = GetStorage();
    final jsonList = notifications.map((n) => n.toJson()).toList();
    box.write('notifications', jsonList);
  }

  List<MiniNotification> getNotifications() {
    final box = GetStorage();
    final jsonList = box.read<List>('notifications') ?? [];
    List<MiniNotification> sm_nots =
        jsonList.map((json) => MiniNotification.fromJson(json)).toList();
    notifications.value = sm_nots;
    return sm_nots;
  }

  final notifications_1 = [
    MiniNotification(
        title: 'Payment Succesfull',
        subtitle: 'A payment of KSH 2300 has been made successfully for parking in lot Mtr23',
        dateTime: 'May  24 - 12:34',
        id: '12w',
        type: 'payment'),
  ];

  void showBottomSheet(String type, String id) {
    Get.bottomSheet(
      paymentBottonSheet(),
      isScrollControlled:
          true, // Allows the bottom sheet to take up the full height
    );
  }

  Widget test() {
    return Container(
      height: 750.h, // Desired height
      width: double.infinity, // Ensure the width fills the parent
      color: Colors.red,
      child: Column(
        children: [],
      ),
    );
  }

  Widget paymentBottonSheet() {
    BuildContext context = Get.context!;
    return Container(
      padding: EdgeInsets.only(top: 20.h, left: 23.w, right: 23.w),
      width: double.maxFinite,
      height: 750.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.sp), topRight: Radius.circular(20.sp)),
      ),
      child: Column(
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
              "Yah have Succesfull paid Ksh 2300 for the parking space on Mrt34 Parking Lot",
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
            color: Colors.red,
            padding: EdgeInsets.all( 5.h),
            child: Text(
                textAlign: TextAlign.center,
                "Already Used",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w400, fontSize: 15.sp, color: Colors.white)),
          ),
          SizedBox(
            height: 35.h,
          ),
          KeyValue(context: context, text: "Amount", value: "Ksh 2300"),
              SizedBox(
            height: 15.h,
          ),
          KeyValue(context: context, text: "Reference ID: ", value: "SKDJFH8SEFS"),
              SizedBox(
            height: 15.h,
          ),
          KeyValue(context: context, text: "Date:", value: "27 May 2024"),
     
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
      ),
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
        Text("$value",
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w400, fontSize: 15.sp)),
      ],
    );
  }
}
