import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RadialGradientCircle extends StatelessWidget {
  final bool light;
  const RadialGradientCircle({
    super.key,
    required this.light,
  });

  @override
  Widget build(BuildContext context) {
    // final brightness = View.of(context).platformDispatcher.platformBrightness;
    final brightness = light;

    final isLightMode = brightness == Brightness.dark;

    List<List<Color>> darkThemeColors = [
      [
        const Color(0xFF808080), // Light gray
        const Color(0xFF606060), // Medium gray
        const Color(0xFF404040), // Dark gray
        const Color(0xFF202020), // Very dark gray
      ],
      [const Color(0xFF4f4f51)],
      [const Color(0xFFFFFFFF)]
    ];

    List<List<Color>> lightThemeColors = [
      [
        const Color(0xFFEFEEF6),
        const Color(0xFFEFEEF6),
        const Color(0xFFEFEEF6),
        const Color.fromRGBO(239, 238, 246, 0.21),
      ],
      [const Color(0xFFEFEEF6)],
      [const Color(0xFFEFEEF6)]
    ];

    return Container(
      height: 385.h,
      width: 385.w,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: isLightMode ? lightThemeColors[0] : darkThemeColors[0],
            stops: const [0.0, 0.3, 0.7, 1.0],
            center: Alignment.center,
            focal: Alignment.center,
            focalRadius: 0.1,
          )),
      child: Center(
        child: Container(
          height: 301.h,
          width: 301.w,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // Shadow color

                spreadRadius: 5, // Spread radius
                blurRadius: 50, // Blur radius
                offset: const Offset(0, 3), // Shadow offset
              ),
            ],
            color: isLightMode ? lightThemeColors[1][0] : darkThemeColors[1][0],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              height: 219.h,
              width: 219.w,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // Shadow color
                    spreadRadius: 5, // Spread radius
                    blurRadius: 50, // Blur radius
                    offset: const Offset(0, 3), // Shadow offset
                  ),
                ],
                color: darkThemeColors[2][0],
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Lanes extends StatelessWidget {
  const Lanes({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLightMode = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      body: Container(
        // padding: EdgeInsets.only(left: 30.w, right: 30.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Transform.rotate(
              // angle: 0,
              angle: -pi / 2, // Rotate 90 degrees counterclockwise

              child: Container(
                width: 350.w,
                height: 250.h,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                      "assets/images/vehicle.png",
                    ))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        10,
                        (index) => Container(
                          width: 23.w,
                          height: 5.h,
                          decoration: BoxDecoration(color:isLightMode?Colors.black: Colors.white),
                        ),
                      ),
                    )),
                    Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        10,
                        (index) => Container(
                          width: 23.w,
                          height: 5.h,
                          decoration: BoxDecoration(color:isLightMode?Colors.black: Colors.white),

                        ),
                      ),
                    ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 385.h,
              width: 5.w,
            )
          ],
        ),
      ),
    );
  }
}

class ShowRoom extends StatelessWidget {
  const ShowRoom({
    super.key,
    required this.light,
  });

  final bool light;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        RadialGradientCircle(light: light),
        Positioned(
          top: 100.h,
          left: -100.w,
          child: Container(
            width: 398.w,
            height: 183.h,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Image.asset("assets/images/vehicle.png"),
          ),
        ),
      ],
    );
  }
}
