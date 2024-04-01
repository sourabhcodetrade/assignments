import 'package:flutter/material.dart';

class MyNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // Called after the pushed route has finished animating in
    print('Route pushed: ${route.settings.name}');
    print('old Route: ${previousRoute?.settings.name}');

  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // Called after the top route has been popped off
    print('Route popped: ${route.settings.name}');
    print('current Route: ${previousRoute?.settings.name}');

  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    // Called after the route has been replaced
    print('Route replaced: ${oldRoute?.settings.name} -> ${newRoute?.settings.name}');
  }

// Other methods such as didRemove, didStartUserGesture, etc., can also be overridden if needed
}
