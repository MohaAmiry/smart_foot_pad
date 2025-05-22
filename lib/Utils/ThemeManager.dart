import 'package:flutter/material.dart';

mixin ThemeManager {
  static const TextStyle titlesStyle = TextStyle(
      color: Color(0xff56595e), fontWeight: FontWeight.bold, fontSize: 18);
  static const TextStyle coloredTitlesStyle = TextStyle(
      color: Color(0xFF274AA8), fontWeight: FontWeight.bold, fontSize: 18);
  static const TextStyle coloredSensorStyle = TextStyle(
      color: Color(0xFF6488E4), fontWeight: FontWeight.bold, fontSize: 18);

  static const TextStyle smallerTitlesStyle = TextStyle(
      color: Color(0xff8f9496), fontWeight: FontWeight.bold, fontSize: 16);

  static const TextStyle coloredSmallerTitlesStyle = TextStyle(
      color: Color(0xFF6488E4), fontWeight: FontWeight.bold, fontSize: 16);

  static const TextStyle labelStyle = TextStyle(
      color: Color(0xFF6488E4), fontWeight: FontWeight.bold, fontSize: 14);

  static const TextStyle largeLabelStyle = TextStyle(
      color: Color(0xFF6488E4), fontWeight: FontWeight.bold, fontSize: 30);

  static const TextStyle bodyStyle = TextStyle(
      color: Color(0xff56595e), fontWeight: FontWeight.normal, fontSize: 14);

  static const TextStyle coloredBodyStyle = TextStyle(
      color: Color(0xFF6488E4), fontWeight: FontWeight.normal, fontSize: 14);

  static const TextStyle subLabelStyle = TextStyle(
      color: Color(0xFF309397), fontWeight: FontWeight.w500, fontSize: 12);

  static const Color backgroundColor = Color(0xfffcfafa);
  static const Color containerColor = Color(0xfff1ecec);
  static const Color coloredContainerColor = Color(0x1D6488E4);
}
