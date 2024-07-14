import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ParkingDetailsController extends GetxController {
  final box = GetStorage();

  TextEditingController vehicleRegController = TextEditingController();
  TextEditingController hrsController = TextEditingController();
  TextEditingController minutesController = TextEditingController();
  TextEditingController secsController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void showPaymentDialog(BuildContext context) {
    String cat = box.read("category") ?? "0";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Booking fee'),
          content: Text(
            textAlign: TextAlign.center,
            'A boking fee of KSH ${cat == "1" ? 100 : 200} is required, press OK to proceed',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontWeight: FontWeight.w400),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                initatePayment(cat);
              },
            ),
          ],
        );
      },
    );
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> getThePositionDetails() async {
    String partId = box.read("selectedPlace") ?? "";
    if (partId.isEmpty) {
      print("Error: partId is empty");
      return null;
    }
    try {
      // Get all document IDs from the collection
      QuerySnapshot querySnapshot = await _firestore
          .collection('lots') // Replace with your actual collection name
          .get();

      // Extract document IDs and filter
      List<String> allDocIds = querySnapshot.docs.map((doc) => doc.id).toList();

      // Iterate over the documents using a for loop
      for (var doc in querySnapshot.docs) {
        String docId = doc.id;
        if (docId.toLowerCase().startsWith(partId.toLowerCase())) {
          print("Full Document ID: $docId");
          return docId;
        }
      }
    } catch (e) {
      print("Error fetching documents: $e");
      return null;
    }
  }

Future<void> saveBooking() async {
    try {
      String? lotId = await getThePositionDetails();
      String? userId = box.read('useId');
      int eta = int.parse(hrsController.text) * 60 + int.parse(minutesController.text);
      String status = "Pending";
      String vehicleRegNo = vehicleRegController.text;
      String phone = phoneController.text;

      if (lotId != null && userId != null) {
        // Create a new document in the 'bookings' collection
        await FirebaseFirestore.instance.collection('bookings').add({
          'lotId': lotId,
          'userId': userId,
          'eta': eta,
          'status': status,
          'vehicleRegNo': vehicleRegNo,
          'phone': phone,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Show success snackbar
        Get.snackbar(
          'Success',
          'Booking saved successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );

        // Navigate to booking_finished page
        Get.offNamed("/booking_finished");
      } else {
        // Show error snackbar if lotId or userId is null
        Get.snackbar(
          'Error',
          'Unable to save booking. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
      }
    } catch (e) {
      // Show error snackbar if an exception occurs
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
    }
  }

  void initatePayment(String cat) {
    String consumerSecret = "kxUnaJKvqrnYxzea";
    String consumerKey = "IPQMSpMGRKm6g45rrCzZRmt1C3xR4MII";
    saveBooking();
  }
}
