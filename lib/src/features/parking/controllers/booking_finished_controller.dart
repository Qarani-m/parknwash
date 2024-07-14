import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingFinishedController extends GetxController {
  final box = GetStorage();
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
    String? lotId = await getThePositionDetails();
    String userId = box.read('useId');
    String eta = "";
    String status = "Pending";

    if (lotId != null && userId != null) {}
  }
}
