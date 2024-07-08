import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:parknwash/src/features/profile/models/mini_notification.dart';
import 'package:parknwash/src/features/profile/models/payment_model.dart';

class PaymentHistoryController extends GetxController {
  RxString title = "Your Payment History".obs;

  RxList<PaymentModel> payment_data = <PaymentModel>[].obs;
  RxList<MiniNotification> payments_list = <MiniNotification>[].obs;

  final box = GetStorage();

  late final StreamSubscription<QuerySnapshot<Map<String, dynamic>>>
      _subscription;

  @override
  void onInit() {
    super.onInit();
    listenToPaymentUpdates();
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }

  void listenToPaymentUpdates() {
    final box = GetStorage();
    String? userJson = box.read<String>('userData');

    if (userJson != null) {
      Map<String, dynamic> userData = jsonDecode(userJson);
      String uid = userData['uid'];

      _subscription = FirebaseFirestore.instance
          .collection('payments')
          .where('uid', isEqualTo: uid)
          .snapshots()
          .listen((querySnapshot) {
        Map<String, PaymentModel> paymentHistoryMap = {};
        for (QueryDocumentSnapshot<Map<String, dynamic>> doc
            in querySnapshot.docs) {
          Map<String, dynamic> data = doc.data();
          String documentId = doc.id;
          PaymentModel payment = PaymentModel.fromMap(data);
          paymentHistoryMap[documentId] = payment;
          MiniNotification miniNotification = MiniNotification(
              title: "Payment Succesfull",
              subtitle:
                  "Succesfully paid Ksh ${payment.amount} for the parking space on ${payment.lotId} Parking Lot",
              dateTime: "",
              id: documentId,
              type: "payments");

          payments_list.value.add(miniNotification);
        }
      }, onError: (error) {
        print('Error listening to payment updates: $error');
      });
    }
  }

  Future<void> getPaymentHistoryFromFirestore() async {
    payments_list.value = [];
    final box = GetStorage();
    String? userJson = box.read<String>('userData');

    if (userJson != null) {
      Map<String, dynamic> userData = jsonDecode(userJson);
      String uid = userData['uid'];

      try {
        // Query Firestore for documents in the "payments" collection where uid matches
        QuerySnapshot<Map<String, dynamic>> querySnapshot =
            await FirebaseFirestore.instance
                .collection('payments')
                .where('uid', isEqualTo: uid)
                .get();

        // Initialize a map to store payment data with document ID as the key
        Map<String, PaymentModel> paymentHistoryMap = {};

        // Iterate through the query results
        for (QueryDocumentSnapshot<Map<String, dynamic>> doc
            in querySnapshot.docs) {
          // Extract document data and the document ID
          Map<String, dynamic> data = doc.data();
          String documentId = doc.id;

          // Create a PaymentModel instance from the data
          PaymentModel payment = PaymentModel.fromMap(data);

          // Add the PaymentModel instance to the map with the document ID as the key
          paymentHistoryMap[documentId] = payment;

          // Print the document ID and amount
          MiniNotification miniNotification = MiniNotification(
              title: "Payment Succesfull",
              subtitle:
                  "Succesfully paid Ksh ${payment.amount} for the parking space on ${payment.lotId} Parking Lot",
              dateTime: "",
              id: documentId,
              type: "payments");

          payments_list.value.add(miniNotification);
        }

        // Print all payment history if needed
        paymentHistoryMap.forEach((id, payment) {});
      } catch (e) {
        print('Error fetching payment history: $e');
      }
    }
  }
}
