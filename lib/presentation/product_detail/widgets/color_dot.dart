import 'package:e_commerce_store/application/product_details/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ColorDot extends StatelessWidget {
  const ColorDot({
    super.key,
    this.fillColor,
  });
  final List? fillColor;

  @override
  Widget build(BuildContext context) {
    context.read<ProductDetailProvider>().isSelected = fillColor![0];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 65.h,
            child: Consumer<ProductDetailProvider>(
              builder: (context, value, child) => ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: fillColor!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => value.selectColor(fillColor![index]),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.all(2),
                      height: 70.h,
                      width: 70.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: fillColor![index] == value.isSelected
                                ? const Color(0xFF707070)
                                : Colors.transparent),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: fillColor!.isEmpty
                              ? Colors.transparent
                              : Color(int.parse(fillColor![index])),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
