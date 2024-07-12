import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:parknwash/src/features/profile/controller/notifications_controller.dart';
import 'package:parknwash/src/features/profile/models/mini_notification.dart';
import 'package:parknwash/src/features/profile/models/payment_model.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
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
