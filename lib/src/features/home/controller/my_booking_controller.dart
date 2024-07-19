import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:parknwash/src/features/home/controller/booking_list_controller.dart';

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
      final hours = matches.elementAt(0).group(0);
      final minutes = matches.elementAt(1).group(0);
      return '$hours : $minutes';
    }
    return timeDifference;
  }

  void startTimer(String status) {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      status =="Pending"?somefunction(): counter();
    });
  }

void somefunction(){}

  void counter() {
    if (seconds.value < 59) {
      price.value +=
          (rates / 3600) * ((hours.value / 3600) + minutes.value / 60);
      seconds.value++;
    } else {
      seconds.value = 0;
      if (minutes.value < 59) {
        minutes.value++;
      } else {
        minutes.value = 0;
        hours.value++;
      }
    }
  }

  Future<void> getWhenParkingStarted(String docId, int cat, String status) async {
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
      price.value =status =="Pending"?0.0: formatHourDifference(timeWhenParkingStarted) *
          int.parse(rates.split(",")[cat]);
    } else {
      return null;
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
  void changeParkingStatus(String type) {
    parkingStatus.value = type;
  }

  void theButton(String condition) {
    if (condition == "Pending") {
      Get.toNamed("/booking_finished");
    } else {
      print("End Parking");
    }
  }

  void cancelBooking() {
    print("Cancel");
  }

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }
}
