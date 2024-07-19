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


  String formatTimeDifference(String timeDifference) {
  final regex = RegExp(r'(\d+)');
  final matches = regex.allMatches(timeDifference);
  if (matches.length >= 2) {
    final hours = matches.elementAt(0).group(0);
    final minutes = matches.elementAt(1).group(0);
    return '$hours : $minutes';
  }
  return timeDifference;
}
}
