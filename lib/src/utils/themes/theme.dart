import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:parknwash/src/utils/constants/colors.dart';

class AppTheme {
  static ThemeData darkTheme() {
    final theme__= Get.theme;
    return ThemeData(
        scaffoldBackgroundColor: AppColors.scaffoldColorDark,
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily: "Urbanist",
        textTheme: TextTheme(
            bodyLarge: TextStyle(
              color: AppColors.whiteTextColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
            bodyMedium: TextStyle(
                color: AppColors.whiteTextColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600),
            bodySmall: TextStyle(
                color: AppColors.whiteTextColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600),
            headlineMedium: TextStyle(
                color: AppColors.whiteTextColor,
                fontSize: 24.sp,
                fontWeight: FontWeight.w400),
            headlineLarge: TextStyle(
                color: AppColors.whiteTextColor,
                fontSize: 33.sp,
                fontWeight: FontWeight.w400)),
            iconTheme:   IconThemeData(color: theme__.scaffoldBackgroundColor));

  }

  static ThemeData lightTheme() {
    final theme__= Get.theme;
    return ThemeData(
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
        brightness: Brightness.light,
        fontFamily: "Urbanist",
        textTheme: TextTheme(
          bodyLarge: TextStyle(
              color: AppColors.blackTextColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600),
          bodyMedium: TextStyle(
              color: AppColors.blackTextColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600),
          bodySmall: TextStyle(
              color: AppColors.blackTextColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600),
          headlineMedium: TextStyle(
              color: AppColors.blackTextColor,
              fontSize: 24.sp,
              fontWeight: FontWeight.w700),
        ),
        iconTheme:   IconThemeData(color: theme__.scaffoldBackgroundColor));
  }
}
