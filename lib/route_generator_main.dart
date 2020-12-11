import 'package:flutter/material.dart';

import 'screens/error/error_screen.dart';
import 'screens/launch/first_login_screen.dart';
import 'screens/launch/launch_screen.dart';
import 'screens/launch/register_screen.dart';
import 'screens/launch/waiting_screen.dart';
import 'screens/app/app.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LaunchScreen());
      case '/first-login':
        return MaterialPageRoute(builder: (_) => FirstLoginScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case '/waiting':
        return MaterialPageRoute(builder: (_) => WaitingScreen());
      case '/app':
        return MaterialPageRoute(builder: (_) => App());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) => ErrorScreen());
  }
}
