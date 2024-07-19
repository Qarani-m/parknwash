import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
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
              realName: data['realName'],
              eta: data["eta"] ?? 0,
              lotId: data['lotId'] ?? "",
              phone: data['phone'] ?? "",
              status: data['status'] ?? "",
              timestamp: await parseFirestoreTimestamp(
                  data['entered'] ?? Timestamp(2, 0)),
              timeDifference: await formatHourDifference(
                  data["entered"],
                  data['left'] ?? Timestamp.now(),
                  data['status'],
                  data['cat'],
                  data['lotId']),
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

  Future<Map<String, String>> parseFirestoreTimestamp(
      Timestamp timestamp) async {
    DateTime dateTime = timestamp.toDate();
    DateFormat dateFormatter = DateFormat('yyyy-MMM-dd'); // Changed format here
    DateFormat timeFormatter = DateFormat('HH:mm:ss');
    String date = dateFormatter.format(dateTime);
    String time = timeFormatter.format(dateTime);
    List<String> dateParts = date.split('-');
    dateParts[1] = dateParts[1];
    date = dateParts.join('-');
    return {
      'date': date,
      'time': time,
    };
  }

  Future<Map<String, String>> formatHourDifference(Timestamp start,
      Timestamp end, String status, int cat, String lotId) async {
    if (status == "Pending") {
      return {"difference": "00 hrs 00 mins", "price": "0"};
    }
    if (status == "Inprogress") {
      end = Timestamp.now();
    }

    DateTime startDateTime = start.toDate();
    DateTime endDateTime = end.toDate();
    Duration difference = endDateTime.difference(startDateTime);
    double hours = difference.inMinutes / 60.0;

    String? rates = await getRate(lotId);
    String price = (hours * int.parse(rates!.split(",")[cat])).toStringAsFixed(2);

    if (hours < 1) {
      int minutes = (hours * 60).round();
      return {
        "difference": '$minutes minute${minutes != 1 ? 's' : ''}',
        "price": price.toString()
      };
    } else if (hours % 1 == 0) {
      int wholeHours = hours.round();
      return {
        "difference": '$wholeHours hour${wholeHours != 1 ? 's' : ''}',
        "price": price.toString()
      };
    } else {
      int wholeHours = hours.floor();
      int minutes = ((hours - wholeHours) * 60).round();

      return {
        "difference":
            '$wholeHours hr${wholeHours != 1 ? 's' : ''} $minutes min${minutes != 1 ? 's' : ''}',
        "price": price.toString()
      };
    }
  }

  Future<String?> getRate(String lotId) async {
    // Access the specific document using the lotId
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('lots').doc(lotId).get();

    // Check if the document exists and return the 'rates' field
    if (documentSnapshot.exists) {
      return documentSnapshot['rates'];
    } else {
      return null;
    }
  }
}
