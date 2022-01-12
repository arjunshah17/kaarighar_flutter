import 'package:flutter/material.dart';
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

var themeGradient=LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      // #39B6A3
      // #2D96A2
      // #2786A1
      // #1F6EA0
      // #1E6BA0
      HexColor("#FF043955"),
      HexColor("#FF043955"),

    ]);

class BasicLoader extends StatelessWidget {
  const BasicLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}