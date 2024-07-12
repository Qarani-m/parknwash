import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:parknwash/src/common_widgets/centric_circes.dart';
import 'package:parknwash/src/features/auth/controllers/onboarding_controller.dart';
import 'package:parknwash/src/utils/constants/colors.dart';

class Onboarding extends StatelessWidget {
  Onboarding({super.key});

  final OnboardingController onboardingController = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLightMode = theme.brightness == Brightness.light;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 40.h),
        child: PageView.builder(
          controller: onboardingController.pageController,
          itemCount: 2, // Number of pages
          onPageChanged: (index) {
            onboardingController.currentIndex.value = index;
          },
          itemBuilder: (_, index) => MainPageOnBoarding(index: index),
        ),
      ),
     
    );
  }
}

class MainPageOnBoarding extends StatelessWidget {
  final int index;
  MainPageOnBoarding({
    super.key,
    required this.index,
  });

  OnboardingController controller = Get.find<OnboardingController>();

  @override
  Widget build(BuildContext context) {
    List<String> titles = ["Car Parking", "Vehicle Cleaning"];
    List<String> subTitles = [
      "You can feel best performance on your drive 💪",
      "Awesome 🧤experience car cleaning service",
    ];
    List<String> icons = [
      "assets/svg/car-front-fill.svg",
      "assets/svg/stars.svg",
    ];
    final theme = Theme.of(context);
    final isLightMode = theme.brightness == Brightness.light;
    return Column(
      children: [
        SizedBox(
          height: 385.h,
          width: 385.w,
          child: index == 0
              ? ShowRoom(
                  light: isLightMode,
                )
              : const Lanes(),
        ),
        SizedBox(
          height: 23.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 23.w, right: 23.w),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    icons[index],
                    height: 36.h,
                    width: 36.h,
                    color: const Color(0xFF33ad5f),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Text(
                    titles[index],
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
              SizedBox(
                height: 23.h,
              ),
              Text(
                subTitles[index],
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(
                height:index==0?90.h: 90.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  index == 0
                      ? GestureDetector(
                          onTap: () => controller.skip(),
                          child: Container(
                            height: 60.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                                color: AppColors.scaffoldColorLight,
                                borderRadius: BorderRadius.circular(15.sp)),
                            child: Center(
                                child: Text(
                              "Skip",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                      color: AppColors.blackTextColor,
                                      fontWeight: FontWeight.w300),
                            )),
                          ),
                        )
                      : const SizedBox(),
                  GestureDetector(
                    onTap: () => controller.next(index),
                    child: Container(
                      height: 60.h,
                      // width: 200.w,
                      width: index == 0 ? 200.w : 328.w,
                      decoration: BoxDecoration(
                          color: AppColors.accentColor,
                          borderRadius: BorderRadius.circular(15.sp)),
                      child: Center(
                          child: Text(
                        index == 0 ? "Next" : "Get Started",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w300),
                      )),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
