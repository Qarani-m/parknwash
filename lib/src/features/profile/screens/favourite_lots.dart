import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavouriteLots extends StatelessWidget {
  const FavouriteLots({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.only(top: 50.h, right: 21.w, left: 21.w),
        child: Column(
          children: [
             Text("Your Favourite Lots"),
             SizedBox(height: 20.h,),

             Favourite()

          ],

        ),
        ),
      ),
    );
  }
}

class Favourite extends StatelessWidget {
  const Favourite({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}