
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parknwash/src/features/auth/controllers/forgot_password_controller.dart';
import 'package:parknwash/src/features/auth/controllers/login_controller.dart';
import 'package:parknwash/src/features/home/controller/homecontroller.dart';
import 'package:parknwash/src/features/profile/controller/payment_history_controller.dart';
import 'package:parknwash/src/features/profile/controller/profile_controller.dart';
import 'package:parknwash/src/utils/constants/colors.dart';
class TimeSpent extends StatelessWidget {
    TimeSpent({
    super.key,
    required this.isLightMode, required this.title, required this.value,
  });

  final bool isLightMode;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.h),
      alignment: Alignment.center,
      height: 70.h,
      width: 164.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.sp),
              bottomLeft: Radius.circular(20.sp)),
          border: Border.all(
              color: !isLightMode
                  ? AppColors.whiteTextColor.withOpacity(0.1)
                  : AppColors.whiteTextColor)),
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w300),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.accentColor, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}

class ProfileListItem extends StatelessWidget {
  const ProfileListItem(
      {super.key,
      required this.icon,
      required this.text,
      required this.function});

  final IconData icon;
  final String text;

  final Function function;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => function(),
          child: Row(
            children: [
              Icon(
                icon,
                size: 35.h,
                color: AppColors.accentColor,
              ),
              SizedBox(
                width: 20.w,
              ),
              Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w300),
              )
            ],
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
      ],
    );
  }
}



// 332