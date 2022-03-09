import 'package:demicare/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DemiBuddy',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(centerTitle: true),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff024da1)),
      ),
      home: const DashboardScreen(),
    );
  }
}
