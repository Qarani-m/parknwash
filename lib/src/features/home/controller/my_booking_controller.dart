import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parknwash/src/features/home/controller/booking_list_controller.dart';
import 'package:parknwash/src/features/home/models/booking_model.dart';
import 'package:parknwash/src/features/home/widgets/checkout.dart';

class MyBookingController extends GetxController {
  BookingListController listController = Get.find<BookingListController>();

  RxBool isLoading = false.obs;
  RxString parkingStatus = "Pending".obs;
  RxInt hours = 00.obs;
  RxInt minutes = 59.obs;
  RxInt seconds = 0.obs;
  RxDouble price = 0.0.obs;
  RxInt rates = 40.obs;
  late Timer timer;

  String timeCounter(String timeDifference) {
    final regex = RegExp(r'(\d+)');
    final matches = regex.allMatches(timeDifference);
    if (matches.length >= 2) {
      hours.value = int.parse(matches.elementAt(0).group(0)!);
      minutes.value = int.parse(matches.elementAt(1).group(0)!);
      return '$hours : $minutes';
    }
    return timeDifference;
  }

  void startTimer(String status) {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      status == "Pending" ? somefunction() : counter();
    });
  }

  void somefunction() {}

  void counter() {
    if (seconds.value < 59) {
      seconds.value++;
    } else {
      seconds.value = 0;
      if (minutes.value < 59) {
        price.value += (rates / 60) * ((hours.value / 60) + minutes.value);
        minutes.value++;
      } else {
        minutes.value = 0;
        hours.value++;
      }
    }
  }

  Future<void> getWhenParkingStarted(
      String docId, int cat, String status) async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('bookings')
        .doc(docId)
        .get();
    if (documentSnapshot.exists) {
      Timestamp timeWhenParkingStarted;
      if (documentSnapshot.exists && documentSnapshot.data() != null) {
        var data = documentSnapshot.data() as Map<String, dynamic>;
        timeWhenParkingStarted = data.containsKey('entered')
            ? data['entered'] as Timestamp
            : Timestamp.now();
      } else {
        timeWhenParkingStarted = Timestamp.now();
      }
      var data = documentSnapshot.data() as Map<String, dynamic>;
      String lotId = data['lotId'] ?? "";

      String rates = await getRate(lotId) ?? "";

      
      print(rates.split(","));
      price.value = status == "Pending"
          ? 0.0
          : formatHourDifference(timeWhenParkingStarted) *
              int.parse(rates.split(",")[cat]);
    } else {
      return;
    }
  }

  Future<String?> getRate(String lotId) async {
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('lots').doc(lotId).get();
    if (documentSnapshot.exists) {
      return documentSnapshot['rates'];
    } else {
      return null;
    }
  }

  double formatHourDifference(Timestamp start) {
    DateTime startDateTime = start.toDate();
    Duration difference = Timestamp.now().toDate().difference(startDateTime);
    double hours = difference.inMinutes / 60.0;

    return hours;
  }

// ----------------------------------------------------------------------------------------

// ----------------------------------------------------------------------------------------
  void changeParkingStatus(String type) {
    parkingStatus.value = type;
  }

  void checkIn(String docId) async {
    Map<String, dynamic> data = {
      'entered': Timestamp.now(),
      'status': 'Inprogress',
    };
    await FirebaseFirestore.instance
        .collection("bookings")
        .doc(docId)
        .update(data)
        .catchError((error) {
      // Handle errors here
      print("Failed to update document: $error");
    });
    parkingStatus.value = "Inprogress";
  }

  void cancelBooking(String docId) async {
    Map<String, dynamic> data = {
      'status': 'Cancelled',
    };
    await FirebaseFirestore.instance
        .collection("bookings")
        .doc(docId)
        .update(data)
        .catchError((error) {
      // Handle errors here
      print("Failed to update document: $error");
    });
    parkingStatus.value = "Cancelled";
  }

  Future<void> navigation(String lotId) async {
    try {
      CollectionReference lots = FirebaseFirestore.instance.collection('lots');
      DocumentSnapshot documentSnapshot = await lots.doc(lotId).get();
      if (documentSnapshot.exists) {
        var coords = documentSnapshot.get('coords');
        if (coords != null && coords is GeoPoint) {
          double latitude = coords.latitude;
          double longitude = coords.longitude;

          Get.toNamed("/navigation_screen",
              arguments: {"lat": latitude, "lng": longitude});
        } else {
          Get.snackbar("Error", "Some Error Occured, 😪",
              snackPosition: SnackPosition.TOP);
        }
      } else {
        Get.snackbar("Error", "Some Error Occured, 😪",
            snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      Get.snackbar("Error", "Some Error Occured, 😪",
          snackPosition: SnackPosition.TOP);
    }
  }

  void endParking(BookingData booking) {
    Get.bottomSheet(
        isScrollControlled: true,
        Container(
          height: 1000.h,
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: Get.theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.sp),
                topRight: Radius.circular(20.sp),
              )),
          child: CheckoutPage(bookingData: booking),
        ));
  }

  void qrCodeTapped(String status) {
    if (status == "Inprogress") {
      Get.snackbar("Info", "End parking session to generate a Qr code",
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.only(bottom: 20.h),
          backgroundColor: Get.theme.scaffoldBackgroundColor);
    }else if(status == "Pending"){

    } else{

    }
  }

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }
}
