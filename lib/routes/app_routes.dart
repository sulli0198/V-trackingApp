import 'package:flutter/material.dart';
import 'package:vtracking_app/screens/splash_screen.dart';

import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
// import 'package:your_app/screens/login_screen.dart';
// import 'package:your_app/screens/profile_screen.dart';
// Import other screens

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String login = '/login';
  // static const String profile = '/profile';
  // Define other routes

  static Map<String, WidgetBuilder> define() {
    return {
      splash: (context) => const SplashScreen(),
      home: (context) =>  const HomeScreen(),
      login: (context) => LoginScreen(),
      // profile: (context) => ProfileScreen(),
      // Map other routes
    };
  }
}


