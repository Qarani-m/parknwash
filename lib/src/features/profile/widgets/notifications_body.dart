import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:parknwash/src/features/profile/controller/notifications_controller.dart';
import 'package:parknwash/src/features/profile/models/mini_notification.dart';
import 'package:parknwash/src/utils/constants/colors.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({
    super.key,
    required this.miniNotification,
    required this.controller,
  });
  final MiniNotification miniNotification;
  final NotificationsController controller;
  @override
  Widget build(BuildContext context) {
    final theme = Get.theme;
    print(theme);
    return GestureDetector(
      onTap: () => controller.showBottomSheet(
          miniNotification.type, miniNotification.id),
      child: Container(
        margin: EdgeInsets.only(bottom: 20.h),
        height: 100.h,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20.sp),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(top: 5.h, left: 5.w, bottom: 5.h),
              height: 65.h,
              width: 100.w,
              decoration: const BoxDecoration(),
              child: SvgPicture.asset(
                "assets/svg/money.svg",
                height: 50.h,
                color: AppColors.accentColor,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10.h),
                  width: 200.w,
                  // color: Colors.lightBlue,
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        miniNotification.dateTime,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: 11.sp),
                      )),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      miniNotification.title,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    SizedBox(
                        width: 220.w,
                        child: Text(miniNotification.subtitle,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(fontWeight: FontWeight.w400)))
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
