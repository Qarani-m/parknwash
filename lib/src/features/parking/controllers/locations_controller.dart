import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;
import 'package:parknwash/src/features/parking/controllers/calculator.dart';
import 'package:parknwash/src/features/parking/widgets/start_booking_bottomsheet.dart';

class LocationsController extends GetxController {
  final box = GetStorage();
  RxInt category = 0.obs;
  RxBool locationEnabled = false.obs;
  RxDouble latitude = 37.43296265331129.obs;
  RxDouble longitude = 122.08832357078792.obs;

  LatLng nearbyLocation1 = const LatLng(-0.3155473, 37.6528756);
  LatLng nearbyLocation2 = const LatLng(-0.3265473, 37.6438756);

  RxList actualNearbyPlaces = [].obs;

  Rx<LatLng?> currentPosition = Rx<LatLng?>(null);

  location.Location locationController = location.Location();

  RxList positions = [].obs;
  final ManualCalculations manualCalculations = ManualCalculations();
  @override
  void onInit() async {
    super.onInit();
    category.value = int.parse(box.read("category") ?? "0");
    await getLocation();
  }

  Future<void> getLocation() async {
    bool serviceEnabled;
    location.PermissionStatus permissionGranted;
    location.LocationData locationData;

    try {
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
          .listen((location.LocationData currentLocation) async {
        if (currentLocation.latitude != null &&
            currentLocation.longitude != null) {
          // currentPosition.value =
          //     LatLng(currentLocation.latitude!, currentLocation.longitude!);

          // actualNearbyPlaces.value =   await manualCalculations.testes(
          //       currentLocation.latitude!, currentLocation.longitude!);

          currentPosition.value =
              const LatLng(37.42796133580664, -122.085749655962);

          actualNearbyPlaces.value = await manualCalculations.testes(
              37.42796133580664, -122.085749655962);
        }
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  getLocationsNearMe() async {
    ManualCalculations manualCalculations = ManualCalculations();
    await manualCalculations.testes(37.42796133580664, -122.085749655962);
  }

  void getBottomSheet(String zone, String rates, double lat, double long) {
    List<String> rate = rates.split(",");

    box.write("selectedPlace", zone);
    box.write("selectedLat", lat);
    box.write("selectedLong", long);

    String cat = box.read("category") ?? "0";

    calculateDistanceBetweenPoints();
    Get.bottomSheet(StartBookingBottomSheet(
      zone: zone,
      distance: "${calculateDistanceBetweenPoints()} KMs away",
      rates: rate[int.parse(cat)],
    ));
  }

  int calculateDistanceBetweenPoints() {
    LatLng point1 = const LatLng(37.7749, -122.4194); // San Francisco
    LatLng point2 = const LatLng(34.0522, -118.2437); // Los Angeles

    double distance = MapUtils.calculateDistance(point1, point2);
    print('Distance between points: ${distance / 1000} km');

    return (distance / 1000).round();
  }

  RxBool greenColor = true.obs;
  RxBool redColor = true.obs;

  void sortPoints(String color) {
    if (color.toLowerCase() == 'red') {
      redColor.value = !redColor.value;
    } else if (color.toLowerCase() == 'green') {
      greenColor.value = !greenColor.value;
    }
  }
}
