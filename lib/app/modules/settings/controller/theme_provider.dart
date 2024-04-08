import 'package:flutter/material.dart';
import '../../../utils/theme/theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData? currentTheme = TAppTheme.lightTheme;
  setLightMode() {
    currentTheme = TAppTheme.lightTheme;
    notifyListeners();
  }

  setDarkMode() {
    currentTheme = TAppTheme.darkTheme;
    notifyListeners();
  }
}
