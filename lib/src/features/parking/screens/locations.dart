import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:parknwash/src/features/parking/controllers/locations_controller.dart';
import 'package:parknwash/src/features/parking/widgets/page_header.dart';
import 'package:parknwash/src/utils/constants/colors.dart';

class LocationsPage extends StatelessWidget {
  LocationsPage({super.key});
  final LocationsController controller = Get.find<LocationsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: controller.currentPosition.value == null
                  ? Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                          color: AppColors.accentColor, size: 40.sp),
                    )
                  : GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: controller.currentPosition.value!,
                        zoom: 11,
                      ),
                      onMapCreated:
                          (GoogleMapController googleMapsController) async {
                        await controller.getLocationsNearMe();
                      },
                      markers: {
                        Marker(
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueBlue),
                          markerId: const MarkerId("currentPosition"),
                          position: controller.currentPosition.value!,
                        ),
                        ...controller.actualNearbyPlaces
                            .map((place) => Marker(
                                  markerId: MarkerId(place['id']
                                      .substring(0, 5)
                                      .toUpperCase()),
                                  position: LatLng(
                                      place['position']['latitude'],
                                      place['position']['longitude']),
                                  onTap: () => {
                                    controller.getBottomSheet(
                                        place['id'], place["rates"]),
                                  },
                                ))
                      },
                    )),
          PageHeader(controller: controller),
        ],
      ),
    );
  }
}
