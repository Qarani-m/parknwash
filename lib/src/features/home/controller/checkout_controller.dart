import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:parknwash/src/features/home/controller/my_booking_controller.dart';
import 'package:parknwash/src/features/home/models/booking_model.dart';
import 'package:parknwash/src/utils/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CheckoutController extends GetxController {
  MyBookingController controller = Get.find<MyBookingController>();

  RxString time = "0".obs;
  RxString location = "Downtown Lot".obs;
  RxDouble rates = 50.0.obs;
  RxString mobile = "0704847676".obs;

  Rxn<BookingData> bookingData = Rxn<BookingData>();

  RxString total = "0".obs;

  TextEditingController phoneController = TextEditingController();
  final box = GetStorage();

  @override
  void onInit() {
    phoneController.text = "";
    total.value = (int.parse(time.value) * rates.value).toString();
    super.onInit();
  }

  Future<void> getFirestoreData(
      String lotId, String documentId, int cat) async {
    String rates = await getRate(lotId) ?? "";
    Timestamp enteredTimeStamp =
        await getArrivalTime(documentId) ?? Timestamp.fromDate(DateTime(2021));
    Timestamp currentTimeStamp = Timestamp.now();

    DateTime enteredDateTime = enteredTimeStamp.toDate();
    DateTime currentDateTime = currentTimeStamp.toDate();

    Duration difference = currentDateTime.difference(enteredDateTime);
    double differenceInHours = difference.inSeconds / 3600;
    String formattedDifferenceInHours = differenceInHours.toStringAsFixed(2);
    time.value = formattedDifferenceInHours;

    double totalValue = double.parse(formattedDifferenceInHours) *
        double.parse(rates.split(",")[cat]);

    total.value = totalValue.toString();
  }

  Future<String?> getRate(String documentId) async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('lots')
        .doc(documentId)
        .get();
    if (documentSnapshot.exists) {
      var data = documentSnapshot.data() as Map<String, dynamic>;

      return data['rates'];
    } else {
      return null;
    }
  }

  Future<Timestamp?> getArrivalTime(String lotId) async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('bookings')
        .doc(lotId)
        .get();
    if (documentSnapshot.exists) {
      return documentSnapshot['entered'] as Timestamp;
    } else {
      return null;
    }
  }

  Future<void> sendPaymentRequest(
      double amount, String phoneNumber, String documentId) async {
    final apiUrl = dotenv.env['PAYMENTS_API_URL'];
    final url =
        Uri.parse('${apiUrl}/payments'); // Replace with your backend URL
    final headers = {"Content-Type": "application/json"};
    final body = json.encode({
      "amount": amount,
      "phoneNumber": phoneNumber,
      "paymentId": documentId
    });

    try {
      Get.bottomSheet(
        BootomSheet(),
      );

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData["success"] == true) {
            Get.back();

          Get.snackbar("Success", responseData["message"],
              snackPosition: SnackPosition.TOP);
            await updateStuff(documentId);
      
        } else {
          Get.back();
          Get.snackbar(
            "Failed",
            responseData["message"],
          );
        }
      } else {
          Get.back();

        Get.snackbar("Error", 'Could not process payment, please try again' ,
            snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
          Get.back();

      Get.snackbar("Error", "Some Error Happened, please try again",
          snackPosition: SnackPosition.TOP);
    }
  }

  void sendRequest(BookingData bookingData) async {
    await sendPaymentRequest(double.parse(total.value), phoneController.text,
        bookingData.documentId);
  }

  Future<void> updateStuff(String docId) async {
    Map<String, dynamic> data = {
      'left': Timestamp.now(),
      'status': 'Completed',
    };

    if (await lookForPayment(docId)) {
      controller.changeParkingStatus("Completed");

      await FirebaseFirestore.instance
          .collection("bookings")
          .doc(docId)
          .update(data)
          .catchError((error) {});
    }
  }
}

Future<bool> lookForPayment(String documentId) async {
  try {
    CollectionReference payments =
        FirebaseFirestore.instance.collection('payments');
    DocumentSnapshot doc = await payments.doc(documentId).get();
    if (doc.exists) {
      return true;
    } else {
      Get.snackbar("Error", "An error Occured, Payment not recieved",
          snackPosition: SnackPosition.TOP);

      return false;
    }
  } catch (e) {
    Get.snackbar("Error", "Some Error Happened ",
        snackPosition: SnackPosition.TOP);
    return false;
  }
}

class BootomSheet extends StatelessWidget {
  const BootomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.sp),
            topRight: Radius.circular(20.sp),
          )),
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            height: 50.h,
            width: double.maxFinite,
            child: Text(
              "PLease wait while we process your payment",
              style: Theme.of(Get.context!)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          SizedBox(
            height: 50.h,
            width: 60.w,
            child: LoadingAnimationWidget.staggeredDotsWave(
                color: AppColors.accentColor, size: 40.w),
          )
        ],
      ),
    );
  }
}
