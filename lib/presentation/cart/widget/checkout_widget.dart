import 'package:flutter/material.dart';
import '../../../core/colors/app_color.dart';
import '../../../widgets/price_widget.dart';
import '../../order_summery/order_summery.dart';

class CheckoutWidget extends StatelessWidget {
  const CheckoutWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Total : ',
          style: TextStyle(fontSize: 25),
        ),
        const PriceWidget(
          fontSize: 25,
          price: '\$200',
        ),
        const Spacer(),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: AppConstantsColor.materialThemeColor,
              foregroundColor: AppConstantsColor.lightTextColor,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScreenOrderSummery(),
                ),
              );
            },
            child: const Text(
              'Checkout',
              style: TextStyle(fontSize: 25),
            ))
      ],
    );
  }
}
