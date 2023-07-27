import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/colors/app_color.dart';
import '../../../core/constants.dart';
import '../../track_order/track_order.dart';

class OdersCustomCard extends StatelessWidget {
  const OdersCustomCard({
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
                    // image: DecorationImage(
                    //   fit: BoxFit.contain,
                    //   image: AssetImage(''),
                    // ),
                    ),
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
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 45.sp),
                  ),
                  constSizedBox20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          fixedSize: Size(270.w, 10.h),
                          elevation: 2,
                        ),
                        onPressed: () {
                          dialogBuilder(context);
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        width: 60.w,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConstantsColor.materialThemeColor,
                          foregroundColor: Colors.white,
                          fixedSize: Size(270.w, 10.h),
                          elevation: 2,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ScreenTrackOrder(),
                            ),
                          );
                        },
                        child: const Text(
                          'Track',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> dialogBuilder(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Cancel Order'),
        content: const Text(
          'Are you sure want to cancel.',
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text(
              'Yes',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
