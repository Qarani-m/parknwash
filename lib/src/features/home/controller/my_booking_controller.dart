import 'package:get/get.dart';

class MyBookingController extends GetxController {
  RxBool isLoading = false.obs;

  RxString parkingStatus = "Pending".obs;

  // Pending Completed Inprogress

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
}
