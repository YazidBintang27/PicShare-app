import 'package:flutter/material.dart';

class AppTypography {
  static const TextStyle _commonStyle = TextStyle(fontFamily: 'Quicksand');

  static TextStyle displaySmall =
      _commonStyle.copyWith(fontSize: 36, fontWeight: FontWeight.w800);

  static TextStyle headlineSmall =
      _commonStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold);

  static TextStyle titleSmall =
      _commonStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold);

  static TextStyle bodyLargeRegular = _commonStyle.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
}