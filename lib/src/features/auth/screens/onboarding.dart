import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:parknwash/src/common_widgets/centric_circes.dart';
import 'package:parknwash/src/utils/constants/colors.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLightMode = theme.brightness == Brightness.light;
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.only(top: 40.h),
          child: PageView.builder(
            itemCount: 2, // Number of pages
            itemBuilder: (_, index) => MainPageOnBoarding(index: index),
          )),
    );
  }
}

class MainPageOnBoarding extends StatelessWidget {
  final int index;
  const MainPageOnBoarding({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    List<String> titles = ["Car Parking", "Vehicle Cleaning"];
    List<String> subTitles = [
      "You can feel best performance on your drive 💪",
      "Awesome 🧤experience car cleaning service",
    ];
    final theme = Theme.of(context);
    final isLightMode = theme.brightness == Brightness.light;
    return Column(
      children: [
        Container(
          height: 385.h,
          width: 385.w,
          child: index == 0
              ? ShowRoom(
                  light: isLightMode,
                )
              : Lanes(),
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
                    "assets/svg/car-front-fill.svg",
                    height: 36.h,
                    width: 36.h,
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
                height: 50.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
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
                          ?.copyWith(color: AppColors.blackTextColor, fontWeight: FontWeight.w300),
                    )),
                  ),
                  Container(
                    height: 60.h,
                    width: 200.w,
                    decoration: BoxDecoration(
                        color: AppColors.accentColor,
                        borderRadius: BorderRadius.circular(15.sp)),
                    child: Center(
                        child: Text(
                      "Next",
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w300),
                    )),
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
