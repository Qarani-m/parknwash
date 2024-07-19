import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:parknwash/src/features/home/models/booking_model.dart';

class BookingListController extends GetxController {
  RxList<BookingData> bookings = <BookingData>[].obs;
  final box = GetStorage();

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    // await getBookings();

    getBookings(extractUid());
    // getBookings("pSgDcrX5XtaXujizeObCw3o5CWb2");
  }

  String extractUid() {
    String jsonString = box.read("userData");
    Map<String, dynamic> userData = jsonDecode(jsonString);
    String uid = userData['uid'];
    return uid;
  }

  Future<void> getBookings(String targetUid) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('bookings')
          .where('userId', isEqualTo: targetUid)
          .get();

      List<BookingData> theData = <BookingData>[];

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          theData.add(BookingData(
              eta: data["eta"] ?? 0,
              lotId: data['lotId'] ?? "",
              phone: data['phone'] ?? "",
              status: data['status'] ?? "",
              timestamp: data['timestamp'] ?? Timestamp(2, 0),
              userId: data["userId"] ?? "",
              vehicleRegNo: data['vehicleRegNo'] ?? "",
              name: data["name"] ?? ""));
        }
        bookings.value = theData;
      } else {
        Get.snackbar("No activity", "No bookings found");
      }
    } catch (e) {
      Get.snackbar("Error", "Some tyoe of error of error happened $e");
    }
  }
}
