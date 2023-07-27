import 'package:e_commerce_store/application/cart/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
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
        FutureBuilder<int>(
          future: Provider.of<CartProvider>(context).getTotalPrice(),
          builder: (context, snapshot) => PriceWidget(
            fontSize: 25,
            price: snapshot.data.toString(),
          ),
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
              Provider.of<CartProvider>(context, listen: false).ids.isNotEmpty
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ScreenOrderSummery(),
                      ),
                    )
                  : Fluttertoast.showToast(
                      msg: 'Add some items in cart to checkout');
            },
            child: const Text(
              'Checkout',
              style: TextStyle(fontSize: 25),
            ))
      ],
    );
  }
}
