import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocationsController extends GetxController {
  final box = GetStorage();

  RxInt category = 0.obs;
  @override
  void onInit() {
    category.value = int.parse(box.read("category"));
    super.onInit();
  }

  void getBottomSheet() {}

  TextEditingController vehicleRegController = TextEditingController();
  TextEditingController hrsController = TextEditingController();
  TextEditingController minutesController = TextEditingController();
  TextEditingController secsController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
}







// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:parknwash/src/features/parking/controllers/locations.dart';

// class LocationsPage extends StatelessWidget {
//   LocationsPage({super.key});

//   final LocationsController controller = Get.find<LocationsController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Larger blue container covering the entire scaffold
//           Container(
//             color: Colors.red,
//             width: double.infinity,
//             height: double.infinity,
//           ),
//           // Smaller red container on top of the larger container
//           Container(
//             margin: EdgeInsets.only(
//               top: 40.h,
//               left: 15.w,
//             ),
//             color: Colors.blue,
//             width: double.maxFinite,
//             height: 500.h,
//             child: Row(
//               children: [
//                 GestureDetector(
//                   onTap: () => controller.getBottomSheet(),
//                   child: Container(
//                     height: 45.h,
//                     width: 50.w,
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10.sp)),
//                     child: const Center(
//                       child: Icon(Icons.arrow_back_ios),
//                     ),
//                   ),
//                 ),
//                            Container(
//             color: Colors.grey.shade100,
//             width: double.maxFinite,
//             height: 100.h,
//           ),
//                 SizedBox(
//                   width: 60.w,
//                 ),
//                 Center(
//                   child: Text(
//                     "Parking near you",
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodyMedium
//                         ?.copyWith(fontWeight: FontWeight.w400),
//                   ),
//                 ),
     
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
