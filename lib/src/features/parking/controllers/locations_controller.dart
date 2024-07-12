import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;
import 'package:parknwash/src/features/parking/controllers/calculator.dart';
import 'package:parknwash/src/features/parking/screens/locations.dart';

class LocationsController extends GetxController {
  final box = GetStorage();
  RxInt category = 0.obs;
  RxBool locationEnabled = false.obs;
  RxDouble latitude = 37.43296265331129.obs;
  RxDouble longitude = 122.08832357078792.obs;

  LatLng nearbyLocation1 = LatLng(-0.3155473, 37.6528756);
  LatLng nearbyLocation2 = LatLng(-0.3265473, 37.6438756);

  Rx<LatLng?> currentPosition = Rx<LatLng?>(null);

  location.Location locationController = new location.Location();

  RxList positions = [].obs;

  @override
  void onInit() async {
    super.onInit();
    category.value = int.parse(box.read("category") ?? "0");
    await getLocation();
    ManualCalculations manualCalculations = ManualCalculations();
    await manualCalculations.testes();
  }

  Future<void> getLocation() async {
    bool serviceEnabled;
    location.PermissionStatus permissionGranted;
    location.LocationData locationData;

    try {
      // Check if location service is enabled
      serviceEnabled = await locationController.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await locationController.requestService();
        if (!serviceEnabled) {
          print('Location services are disabled.');
          return;
        }
      }
      // Check location permission
      permissionGranted = await locationController.hasPermission();
      if (permissionGranted == location.PermissionStatus.denied) {
        permissionGranted = await locationController.requestPermission();
        if (permissionGranted != location.PermissionStatus.granted) {
          print('Location permissions are denied.');
          return;
        }
      }

      // Get location data
      locationData = await locationController.getLocation();
      latitude.value = locationData.latitude!;
      longitude.value = locationData.longitude!;

      locationController.onLocationChanged
          .listen((location.LocationData currentLocation) {
        if (currentLocation.latitude != null &&
            currentLocation.longitude != null) {
          currentPosition.value =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);

          print(currentLocation);
        }
        ;
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  getLocationsNearMe() async {
    ManualCalculations manualCalculations = new ManualCalculations();
    await manualCalculations.testes();
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
