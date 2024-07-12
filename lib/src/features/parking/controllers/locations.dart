import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:parknwash/src/features/parking/screens/locations.dart';

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationsController extends GetxController {
  final box = GetStorage();
  RxInt category = 0.obs;
  RxBool locationEnabled = false.obs;
  RxDouble latitude = 37.43296265331129.obs;
  RxDouble longitude = 122.08832357078792.obs;

  @override
  void onInit() async {
    super.onInit();
    category.value = int.parse(box.read("category") ?? "0");
    await handleLocation();
  }




























  Future<void> handleLocation() async {
    locationEnabled.value = await Geolocator.isLocationServiceEnabled();

    if (!locationEnabled.value) {
      showSnackbar("Error", "Location services are not enabled");
      Get.back();
      return;
    }

    var permission = await Permission.location.status;
    if (permission == PermissionStatus.denied) {
      permission = await Permission.location.request();
      if (permission == PermissionStatus.denied) {
        showSnackbar("Error", "Location permission denied");
        Get.back();
        return;
      }
    }

    if (permission == PermissionStatus.granted) {
      await getCurrentPosition();
    } else {
      showSnackbar("Error", "Location permission not granted");
      
      Get.back();
    }
  }

  Future<void> getCurrentPosition() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude.value = position.latitude;
      longitude.value = position.longitude;
      showSnackbar("Success",
          "Current coordinates: ${position.latitude}, ${position.longitude}");
    } catch (e) {
      showSnackbar("Error", "Error getting location: $e");
    }
  }

  void showSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 3),
    );
  }

  void getBottomSheet(String zone) {
    Get.bottomSheet(StartBookingBottomSheet(
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
