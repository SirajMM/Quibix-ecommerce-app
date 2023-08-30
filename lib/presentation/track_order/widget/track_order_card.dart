import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_store/presentation/widgets/price_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants.dart';

class TrackOrderCard extends StatelessWidget {
  const TrackOrderCard({
    super.key,
    this.data,
    required this.orderData,
  });
  final QueryDocumentSnapshot<Map<String, dynamic>>? data;
  final Map<String, dynamic>? orderData;
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
                width: 340.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: NetworkImage(data!['imageList'][0]),
                  ),
                ),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  constSizedBox10,
                  SizedBox(
                    width: 640.w,
                    child: Text(
                      data!['productname'] ?? '',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 45.sp),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  constSizedBox10,
                  Text(
                    '${orderData!.isNotEmpty ? orderData!['count'] : 1} Item',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 55.sp),
                  ),
                  Row(
                    children: [
                      const Text(
                        'Color: ',
                        style: TextStyle(fontSize: 17),
                      ),
                      orderData!['color'] != null
                          ? Container(
                              height: 40.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                color: Color(int.parse(orderData!['color']!)),
                                shape: BoxShape.circle,
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                  // constSizedBox20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      PriceWidget(
                        fontSize: 25,
                        price: data!['price'] ?? '',
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
