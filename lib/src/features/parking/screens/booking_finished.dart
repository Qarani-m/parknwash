import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:parknwash/src/features/parking/controllers/booking_finished_controller.dart';
import 'package:parknwash/src/features/parking/controllers/locations_controller.dart';
import 'package:parknwash/src/features/parking/widgets/page_header.dart';
import 'package:parknwash/src/utils/constants/colors.dart';
import 'package:parknwash/src/utils/constants/map_styles.dart';

class BookingFinished extends StatelessWidget {
  BookingFinished({super.key});

  final BookingFinishedController controller =
      Get.find<BookingFinishedController>();
        final LocationsController locationscontroller = Get.find<LocationsController>();
        

  @override
  Widget build(BuildContext context) { 
        final theme = Get.theme;
    final isDarkMode = theme.brightness == Brightness.dark;
   
    return Scaffold(
      body: Stack(
        children: [
          Obx (()=>SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: locationscontroller.currentPosition.value == null
                  ? Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                          color: AppColors.accentColor, size: 40.sp),
                    )
                  : GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: locationscontroller.currentPosition.value!,
                        zoom: 11,
                      ),
                      onMapCreated:
                          (GoogleMapController googleMapsController) async {
                        googleMapsController
                            .setMapStyle(isDarkMode ? AppMapStyles.darkMapStyle : AppMapStyles.lightMapStyle,);
                        await locationscontroller.getLocationsNearMe();
                      },
                      markers: {
                        Marker(
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueBlue),
                          markerId: const MarkerId("currentPosition"),
                          position: locationscontroller.currentPosition.value!,
                        ),
                        ...locationscontroller.actualNearbyPlaces.map((place) => Marker(
                              markerId: MarkerId(
                                  place['id'].substring(0, 5).toUpperCase()),


                                  icon: place['type']=="private"? BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueGreen): BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueRed),
                              position: LatLng(place['position']['latitude'],
                                  place['position']['longitude']),
                              onTap: () => {
                                locationscontroller.getBottomSheet(
                                    place['id'], 
                                    place["rates"],
                                    place['position']['latitude'],
                                  place['position']['longitude']
                                    
                                    ),
                              },
                            ))
                      },
                    )),),
          PageHeader(controller: locationscontroller, showQrCode: true,goToHomePage: true,),
        ],
      ),
    );
  }
}
