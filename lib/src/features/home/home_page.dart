import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:parknwash/src/common_widgets/centric_circes.dart';
import 'package:parknwash/src/features/home/controller/homecontroller.dart';
import 'package:parknwash/src/utils/constants/colors.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});
   final Homecontroller controller  = Get.put<Homecontroller>(Homecontroller());
  @override
  Widget build(BuildContext context) {
    List<String> categories = ["Car", "Bike", "Bus"];
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: 50.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 23.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 60.h,
                    width: double.maxFinite,
                    padding: EdgeInsets.only(right: 23.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 60.h,
                          width: 60.h,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10.sp)),
                        ),
                        Container(
                          height: 40.h,
                          width: 40.h,
                          color: Colors.blue,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35.h,
                  ),
                  Text(
                    "Hello, Muhamed",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "We make parking",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    "Easy",
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontSize: 35.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 35.h,
                  ),
                ],
              ),
            ),
        

            Container(
              width: double.maxFinite,
              child: 
              
              
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      3,
                      (index) => GestureDetector(
                            onTap: () => controller.changeButtonColor(index),
                            child: Container(
                              height: 120.h,
                              width: 115.h,
                              decoration: BoxDecoration(
                                color: Color(0xFF252525),
                                borderRadius: BorderRadius.circular(15.sp),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset(
                                    "assets/svg/car-front-fill.svg",
                                    color: AppColors.blackTextColor,
                                    width: 60.h,
                                    height: 60.h,
                                  ),
                                  Text(
                                    categories[index],
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: AppColors.blackTextColor,
                                        ),
                                  )
                                ],
                              ),
                            ),
                          ))),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.maxFinite,
                  height: 370.h,
                  padding: EdgeInsets.only(top: 10.h),
                  child: const Lanes(),
                ),
                Positioned(
                  top: 205.h,
                  left:
                      (MediaQuery.of(context).size.width / 2) - (153.h / 2) - 5,
                  child: Container(
                    width: 153.h,
                    height: 153.h,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xFFFEDD66)),
                    child: Center(
                        child: Text(
                      "Start\n to find parking",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColors.blackTextColor),
                    )),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
