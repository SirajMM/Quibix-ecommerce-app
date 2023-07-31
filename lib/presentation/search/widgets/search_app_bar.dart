import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/colors/app_color.dart';

class SearchCustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const SearchCustomAppBar({super.key, required this.onChanged});
  final void Function(String)? onChanged;
  @override
  Size get preferredSize => const Size.fromHeight(90.0);
  @override
  Widget build(BuildContext context) {
    var respsize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 50, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: respsize.height * 0.05,
            width: respsize.width * 0.8,
            child: Material(
              elevation: 5,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: TextField(
                onChanged: onChanged,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    CupertinoIcons.search_circle_fill,
                    size: respsize.width * 0.09,
                    color: AppConstantsColor.materialThemeColor,
                  ),
                  filled: true,
                  fillColor: AppConstantsColor.lightTextColor,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
