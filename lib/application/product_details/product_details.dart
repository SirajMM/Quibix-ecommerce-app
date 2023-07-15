// import 'dart:ui';
import 'package:flutter/material.dart';


class ProductDetailProvider extends ChangeNotifier {
  Color? dominantColor;
  int? currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void retrieveDominantColor(imageColor) async {
    // ReceivePort receivePort = ReceivePort();
    // await Isolate.spawn(
    //     _retrieveDominantColorIsolate, [imageColor, receivePort.sendPort]);
    // await for (var color in receivePort) {
    //   dominantColor = color;
    //   notifyListeners();
    // }
  }

  // void _retrieveDominantColorIsolate(List args) async {
  //   String imageColor = args[0];
  //   SendPort sendPort = args[1];
  //   final PaletteGenerator paletteGenerator =
  //       await PaletteGenerator.fromImageProvider(
  //     NetworkImage(imageColor),
  //     size: const Size(10, 10),
  //   );
  //   Color dominantColor = paletteGenerator.dominantColor!.color;
  //   sendPort.send(dominantColor);
  // }
}
