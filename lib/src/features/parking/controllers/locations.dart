import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:parknwash/src/features/parking/screens/locations.dart';

class LocationsController extends GetxController {
  final box = GetStorage();

  RxInt category = 0.obs;
  @override
  void onInit() {
    category.value = int.parse(box.read("category"));
    super.onInit();
  }

  void getBottomSheet(String zone) {
    Get.bottomSheet(      
      StartBookingBottomSheet(
      zone: zone,
      rates: '40',
    ));
  }

  TextEditingController vehicleRegController = TextEditingController();
  TextEditingController hrsController = TextEditingController();
  TextEditingController minutesController = TextEditingController();
  TextEditingController secsController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
}
