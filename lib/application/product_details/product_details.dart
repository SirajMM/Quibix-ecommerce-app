// import 'dart:ui';

import 'package:flutter/material.dart';

class ProductDetailProvider extends ChangeNotifier {
  Color? dominantColor;
  int? currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void retrieveDominantColor(String imageColor) async {
    //   ReceivePort receivePort = ReceivePort();
    //   await Isolate.spawn(
    //     retrieveDominantColorIsolate, // Pass the function as the first argument
    //     [
    //       receivePort.sendPort,
    //       imageColor
    //     ], // Pass the arguments after the function name
    //   );
    //   receivePort.listen((color) {
    //     dominantColor = color;
    //     notifyListeners();
    //   });
  }
}

// retrieveDominantColorIsolate(List args) async {
//   SendPort sendPort = args[0];
//   String imageColor = args[1];
//   final PaletteGenerator paletteGenerator =
//       await PaletteGenerator.fromImageProvider(
//     NetworkImage(imageColor),
//     size: const Size(10, 10),
//   );
//   Color dominantColor = paletteGenerator.dominantColor!.color;
//   sendPort.send(dominantColor);
// }
