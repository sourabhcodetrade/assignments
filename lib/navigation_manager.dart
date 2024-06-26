import 'package:flutter/material.dart';

final class NavigationManager {
  static final NavigationManager instance = NavigationManager._();
  factory NavigationManager() => instance;

  NavigationManager._();

 static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
