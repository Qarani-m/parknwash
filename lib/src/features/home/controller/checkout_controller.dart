import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:parknwash/src/features/home/models/booking_model.dart';
import 'package:parknwash/src/utils/constants/colors.dart';

class CheckoutController extends GetxController {
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
    print(documentId);
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

  void sendRequest(BookingData bookingData) async{
   await  updateStuff(bookingData.documentId);
    Get.offAllNamed("/my_bookings", arguments: {"bookingData": bookingData});

    // Get.bottomSheet(
    //   BootomSheet(),
    //   isDismissible: false,  // Prevent user from dismissing the sheet
    // );

    // // Wait for 1 minute, then close the bottom sheet and show error
    // Future.delayed(Duration(seconds: 3), () {
    //   // Close the bottom sheet
    //   Get.back();

    //   // Show error message
    //   Get.snackbar(
    //     'Error',
    //     'Something went wrong',
    //     snackPosition: SnackPosition.TOP,
    //     backgroundColor: Colors.red,
    //     colorText: Colors.white,
    //     duration: Duration(seconds: 3),
    //   );
    // });
  }
}

  Future<Timestamp?> updateStuff(String docId) async {
        Map<String, dynamic> data = {
      'left': Timestamp.now(),
      'status': 'Completed',
    };

    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('bookings')
        .doc(docId)
        .get();
    if (documentSnapshot.exists) {
      return documentSnapshot['entered'] as Timestamp;
    } else {
      return null;
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
