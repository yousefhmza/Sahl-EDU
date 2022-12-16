import 'package:flutter/material.dart';

import '../../modules/splash/view/screens/splash_screen.dart';
import '../../core/view/views.dart';
import 'navigation.dart';

class RouteGenerator {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return platformPageRoute(const SplashScreen());
      default:
        return platformPageRoute(const UndefinedRouteScreen());
    }
  }
}
