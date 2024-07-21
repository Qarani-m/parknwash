import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parknwash/src/features/home/controller/checkout_controller.dart';
import 'package:parknwash/src/features/home/models/booking_model.dart';
import 'package:parknwash/src/utils/constants/colors.dart';

class CheckoutPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final CheckoutController controller = Get.find<CheckoutController>();

  String _phoneNumber = '';
  final BookingData bookingData;

  CheckoutPage({super.key, required this.bookingData});

  @override
  Widget build(BuildContext context) {
    controller.phoneController.text = bookingData.phone;
    controller.bookingData.value = bookingData;
    controller.getFirestoreData(bookingData.lotId, bookingData.documentId, bookingData.cat);
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      body: Obx(()=>SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 50.h, left: 23.w, right: 23.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildParkingSummary(context),
              const SizedBox(height: 16),
              _buildPaymentForm(context),
              const SizedBox(height: 16),
              _buildPaymentInfo(
                  context,
                  "After clicking 'Pay with M-Pesa', you'll receive a prompt on your phone to complete the payment.",
                  false),
              SizedBox(
                height: 20.h,
              ),
              _buildPaymentInfo(
                  context,
                  "The generated QR code for payment is only valid for 30 minutes. Please ensure you collect your car within this time to avoid additional charges.",
                  true),
            ],
          ),
        ),
      ),)
    );
  }

  Widget _buildParkingSummary(BuildContext context) {
    return Card(
      shadowColor: Colors.white.withOpacity(0.1),
      color: Get.theme.scaffoldBackgroundColor,
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Parking Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15.h),
            _buildSummaryRow(
                context, 'Duration:', '${controller.time.value} hours'),
            _buildSummaryRow(context, 'Location:', bookingData.realName),
            const Divider(),
            _buildSummaryRow(
                context, 'Total:', 'Ksh ${controller.total.value} ',
                isTotal: true),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(BuildContext context, String label, String value,
      {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Container(
            width: 200.w,
            alignment: Alignment.centerRight,
            child: Text(
              overflow: TextOverflow.ellipsis,
              value,
              style: isTotal
                  ? Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w100)
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentForm(BuildContext context) {
    return Card(
      shadowColor: Colors.white.withOpacity(0.1),
      color: Get.theme.scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Payment: M-Pesa',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 50.h,
                child: TextFormField(
                  controller: controller.phoneController,
                  decoration: InputDecoration(
                    labelText: 'M-Pesa Phone Number',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.w400),
                    labelStyle: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.w400),
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your M-Pesa phone number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _phoneNumber = value!;
                  },
                ),
              ),
              SizedBox(height: 30.h),
              GestureDetector(
                onTap: () => controller.sendRequest(bookingData),
                child: Container(
                  alignment: Alignment.center,
                  height: 55.h,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: AppColors.accentColor,
                      borderRadius: BorderRadius.all(Radius.circular(20.sp))),
                  child: Text(
                    'Pay Ksh ${controller.total.value} with M-Pesa',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.scaffoldColorDark),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentInfo(BuildContext context, String info, bool warning) {
    return Card(
      color: Get.theme.scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.info_outline,
                color: warning ? const Color(0xFFDc143c) : Colors.blue),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Payment Process',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    info,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w400, fontSize: 13.sp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
