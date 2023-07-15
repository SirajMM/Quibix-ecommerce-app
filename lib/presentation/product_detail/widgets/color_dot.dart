import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorDot extends StatelessWidget {
  const ColorDot({
    super.key,
    this.fillColor,
    this.isSelected = false,
  });
  final List? fillColor;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 65.h,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: fillColor!.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.all(2),
                  height: 65.h,
                  width: 65.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: isSelected
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
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
