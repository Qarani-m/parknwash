import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parknwash/src/features/profile/models/lot_model.dart';
import 'package:parknwash/src/utils/constants/colors.dart';


class Favourite extends StatelessWidget {
    const Favourite({
    super.key, required this.lot,
  });

  final Lot lot;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h,
      width: double.maxFinite,
      decoration: const BoxDecoration(

          // color: Colors.red

          ),
      child: Row(
        children: [
          Container(
            height: 120.h,
            width: 120.w,
            decoration: BoxDecoration(
                color: Colors.green,
                image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      "assets/images/download.jpeg",
                    )),
                borderRadius: BorderRadius.circular(15.sp)),
          ),
          SizedBox(
            width: 10.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(lot.name),
              Text(
                "\$ ${lot.rates}/hr",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 17.sp, fontWeight: FontWeight.w300),
              ),
              Row(
                children: [
                  const Icon(Icons.location_history),
                  const SizedBox(
                    width: 5.2,
                  ),
                  Text(
                    lot.locality,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 17.sp, fontWeight: FontWeight.w300),
                  )
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: AppColors.accentColor,
                    size: 20.h,
                  ),
                  const SizedBox(
                    width: 5.2,
                  ),
                  Text(
                    lot.rates.toString(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 15.sp, fontWeight: FontWeight.w300),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
