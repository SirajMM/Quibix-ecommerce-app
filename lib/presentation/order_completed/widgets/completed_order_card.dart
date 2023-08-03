import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_store/presentation/product_detail/product_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../application/orders/orders_provider.dart';
import '../../../core/constants.dart';

class OrderCompleteCard extends StatelessWidget {
  const OrderCompleteCard({super.key, required this.orderData});
  final QueryDocumentSnapshot<Map<String, dynamic>> orderData;

  @override
  Widget build(BuildContext context) {
    late DocumentSnapshot<Object?> data;
    return StreamBuilder<DocumentSnapshot>(
      stream: Provider.of<OrdersProvider>(context, listen: false)
          .getProductData(orderData['cartList']),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading data'));
        } else {
          data = snapshot.data!;

          return GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ScreenProductDetails(details: snapshot.data!),
                )),
            child: SizedBox(
              height: 250.h,
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
                        height: 250.h,
                        width: 230.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: NetworkImage(data['imageList'][0]),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          constSizedBox10,
                          SizedBox(
                            width: 629.w,
                            child: Text(
                              data['productname'],
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 45.sp),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'Delivered',
                            style: TextStyle(
                                fontSize: 45.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.green),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
