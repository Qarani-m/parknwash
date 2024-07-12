import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parknwash/src/features/profile/controller/favourites_controller.dart';
import 'package:parknwash/src/features/profile/widgets/favourites_widget.dart';


class FavouriteLots extends StatelessWidget {
  FavouriteLots({super.key});
  final FavouritesController controller = Get.find<FavouritesController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 50.h, right: 21.w, left: 21.w),
          child: Obx(
            () => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(Icons.arrow_back),
                    ),
                    const Text("Your Favourites"),
                    SizedBox(width: 23.w),
                  ],
                ),
                SizedBox(height: 20.h),
                if (controller.isLoading.value)
                  const Center(child: CircularProgressIndicator())
                else if (controller.favouriteLots.isEmpty)
                  const Center(child: Text("No favourite lots found"))
                else
                  ...controller.favouriteLots.map((lot) => Favourite(lot: lot)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
