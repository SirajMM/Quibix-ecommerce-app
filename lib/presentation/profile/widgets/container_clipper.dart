import 'package:flutter/material.dart';

class ContainerClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(size.height, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;
}
