import 'package:flutter/material.dart';

class ColorManager {
  static Color bg1 = HexColor.fromHex('#1F4247');
  static Color bg2 = HexColor.fromHex('#0D1D23');
  static Color bg3 = HexColor.fromHex('#09141A');
  static Color bg4 = HexColor.fromHex('#162329');
  static Color bg5 = HexColor.fromHex('#0E191F');
  static Color btn1 = HexColor.fromHex('#62CDCB');
  static Color btn2 = HexColor.fromHex('#4599DB');
  static Color golden1 = HexColor.fromHex('#94783E');
  static Color golden2 = HexColor.fromHex('#F3EDA6');
  static Color golden3 = HexColor.fromHex('#F8FAE5');
  static Color golden4 = HexColor.fromHex('#FFE2BE');
  static Color golden5 = HexColor.fromHex('#D5BE88');
  static Color golden6 = HexColor.fromHex('#F8FAE5');
  static Color golden7 = HexColor.fromHex('#D5BE88');
  static Color sky1 = HexColor.fromHex('ABFFFD');
  static Color sky2 = HexColor.fromHex('4599DB');
  static Color sky3 = HexColor.fromHex('AADAFF');
  static Color white = HexColor.fromHex('#FFFFFF');
  static Color grey = HexColor.fromHex('#D9D9D9');
  static Color greyWithOpacity1 = HexColor.fromHex('#D9D9D9').withOpacity(0.06);
  static Color whiteWithOpacity1 = HexColor.fromHex('#FFFFFF').withOpacity(0.4);
  static Color whiteWithOpacity2 =
      HexColor.fromHex('#FFFFFF').withOpacity(0.52);
  static Color whiteWithOpacity3 =
      HexColor.fromHex('#FFFFFF').withOpacity(0.19);
  static Color whiteWithOpacity4 =
      HexColor.fromHex('#FFFFFF').withOpacity(0.06);
  static Color whiteWithOpacity5 =
      HexColor.fromHex('#FFFFFF').withOpacity(0.08);
  static Color whiteWithOpacity6 =
      HexColor.fromHex('#FFFFFF').withOpacity(0.33);
  static Color whiteWithOpacity7 = HexColor.fromHex('#FFFFFF').withOpacity(0.3);
  static Color whiteWithOpacity8 =
      HexColor.fromHex('#FFFFFF').withOpacity(0.22);
  static Color whiteWithOpacity9 = HexColor.fromHex("FFFFFF").withOpacity(0.1);
  static LinearGradient btnPrimary = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [btn1, btn2]);
  static RadialGradient bgPrimary = RadialGradient(
    center: const Alignment(0.5, -2),
    radius: 24,
    colors: [bg1, bg2, bg3],
    // stops: const [0.4, 1.0],
  );
  static LinearGradient txtPrimary = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [golden1, golden2, golden3, golden4, golden5, golden6, golden7]);
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = 'FF$hexColorString';
    }

    return Color(int.parse(hexColorString, radix: 16));
  }
}
