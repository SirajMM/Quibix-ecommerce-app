import 'package:flutter/cupertino.dart';
import 'package:palette_generator/palette_generator.dart';

class ProductDetailProvider extends ChangeNotifier {
  Color? dominantColor;
  void retrieveDominantColor(imageColor) async {
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
      NetworkImage(imageColor),
      size: const Size(200, 200),
    );

    dominantColor = paletteGenerator.dominantColor!.color;
    notifyListeners();
  }
}
