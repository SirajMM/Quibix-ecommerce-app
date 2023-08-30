import 'package:flutter/material.dart';

class FullScreenWidget extends StatelessWidget {
  const FullScreenWidget({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Hero(
            tag: 'proImage',
            child: GestureDetector(
                onPanDown: (details) => Navigator.pop(context),
                child: Image.network(image))));
  }
}
