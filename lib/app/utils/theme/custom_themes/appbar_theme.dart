import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class TAppBarTheme {
  TAppBarTheme._();

  static AppBarTheme lightAppBarTheme = const AppBarTheme(
    backgroundColor: Constants.lightAppBarColor,
  );
  static AppBarTheme darkAppBarTheme = const AppBarTheme(
    backgroundColor: Constants.darkAppBarColor,
  );
}
