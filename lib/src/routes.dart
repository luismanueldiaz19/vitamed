import 'package:flutter/material.dart';
import 'screens/folder_screen_main/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/splash_screen.dart';

class Routes {
  static const String splashScreen = '/splash_screen';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String profile = '/profile';
  static const String project = '/project';
  static const String add_ground = '/add_ground';

  // SplashScreen
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home: return MaterialPageRoute(builder: (_) => const MyHomePage(title: 'Vitamed'));
      case login: return MaterialPageRoute(builder: (_) => const LoginScreen());
      case project: return MaterialPageRoute(builder: (_) => MyHomePage(title: 'Vitamed'));
      case splashScreen: return MaterialPageRoute(builder: (_) => SplashScreen());
      default: return MaterialPageRoute(builder: (_) => const MyHomePage(title: 'Vitamed'));
    }
  }
}
