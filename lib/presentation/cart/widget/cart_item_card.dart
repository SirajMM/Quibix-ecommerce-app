import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/colors/app_color.dart';
import '../../../widgets/price_widget.dart';

int count = 1;

class CartItemCard extends StatefulWidget {
  const CartItemCard({
    super.key,
  });

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      color: Colors.transparent,
      child: Container(
        height: 280.h,
        decoration: const BoxDecoration(
            color: AppConstantsColor.lightTextColor,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 25.0, right: 45, bottom: 15, top: 15)
                  .r,
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "APPLE 2020 Macbook Air M1 -\n(8 GB/256 GB SSD/Mac OS Big Sur)",
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 45.sp),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Container(
                        height: 90.h,
                        width: 350.w,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: AppConstantsColor.materialThemeColor),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            count > 0
                                ? InkWell(
                                    splashColor: Colors.black,
                                    onTap: () {
                                      setState(() {
                                        count--;
                                      });
                                    },
                                    child: Icon(
                                      CupertinoIcons.minus,
                                      color: AppConstantsColor.lightTextColor,
                                      size: 65.sp,
                                    ),
                                  )
                                : Icon(
                                    Icons.remove,
                                    color: Colors.grey,
                                    size: 65.sp,
                                  ),
                            Text(
                              '$count',
                              style: TextStyle(
                                  fontSize: 65.sp,
                                  color: AppConstantsColor.lightTextColor,
                                  fontWeight: FontWeight.w600),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  count++;
                                });
                              },
                              child: Icon(
                                CupertinoIcons.add,
                                color: AppConstantsColor.lightTextColor,
                                size: 65.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 50.sp,
                      ),
                      const PriceWidget(fontSize: 24)
                    ],
                  )
                ],
              ),
              const Spacer(),
              Container(
                height: 240.h,
                width: 240.w,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/images.jpg'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
