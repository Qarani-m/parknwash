import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:parknwash/src/features/parking/controllers/locations_controller.dart';
import 'package:parknwash/src/features/parking/widgets/page_header.dart';
import 'package:parknwash/src/utils/constants/colors.dart';
import 'package:parknwash/src/utils/constants/map_styles.dart';

class NavigationScreen extends StatelessWidget {
  NavigationScreen({super.key});
  final LocationsController controller = Get.find<LocationsController>();
  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;
    final isDarkMode = theme.brightness == Brightness.dark;

    final arguments = Get.arguments as Map;
    final double lat = arguments['lat'];
    final double lng = arguments['lng'];

    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => SizedBox(
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
                          googleMapsController.setMapStyle(
                            isDarkMode
                                ? AppMapStyles.darkMapStyle
                                : AppMapStyles.lightMapStyle,
                          );
                       
                        },
                        markers: {
                          Marker(
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueBlue),
                            markerId: const MarkerId("currentPosition"),
                            position: controller.currentPosition.value!,
                          ),
                           Marker(
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueGreen),
                            markerId: const MarkerId("parking_location"),
                            position: LatLng(lat, lng),
                          ),
                        },

                        
                      )),
          ),
          PageHeader(controller: controller),
        ],
      ),
    );
  }
}
