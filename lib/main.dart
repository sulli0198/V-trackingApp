import 'package:flutter/material.dart';
import 'package:vtracking_app/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vehicle Tracking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.splash, // Set the initial route to splash screen
      routes: AppRoutes.define(), // Use the routes defined in AppRoutes
    );
  }
}
