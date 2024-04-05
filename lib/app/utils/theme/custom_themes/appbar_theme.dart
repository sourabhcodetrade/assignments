import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class TAppBarTheme {
  TAppBarTheme._();

  static AppBarTheme lightAppBarTheme = const AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    backgroundColor: Constants.lightAppBarColor,
  );
  static AppBarTheme darkAppBarTheme = const AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    backgroundColor: Constants.darkAppBarColor,
  );
}
