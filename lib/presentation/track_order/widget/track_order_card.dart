import 'package:e_commerce_store/widgets/price_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants.dart';

class TrackOrderCard extends StatelessWidget {
  const TrackOrderCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 550.h,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          side: BorderSide(
            width: .5,
            color: Colors.black,
          ),
        ),
        surfaceTintColor: Colors.transparent,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(20.0).r,
          child: Row(
            children: [
              Container(
                height: 350.h,
                width: 350.w,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage('assets/images/images.jpg'))),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  constSizedBox10,
                  Text(
                    "APPLE 2020 Macbook Air M1 -\n(8 GB/256 GB SSD/Mac OS Big Sur)",
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 45.sp),
                  ),
                  constSizedBox10,
                  Text(
                    '1 Item',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 55.sp),
                  ),
                  constSizedBox20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const PriceWidget(
                        fontSize: 25,
                        price: '\$200',
                      ),
                      SizedBox(
                        width: 60.w,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
