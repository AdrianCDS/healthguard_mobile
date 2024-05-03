import 'package:flutter/material.dart';
import 'package:healthguard_mobile/pages/dashboard.dart';
import 'package:healthguard_mobile/pages/homepage.dart';
import 'package:healthguard_mobile/pages/login.dart';
import 'package:healthguard_mobile/pages/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Homepage(),
      routes: {
        '/register': (context) => const Register(),
        '/login': (context) => const Login(),
        '/dashboard': (context) => const Dashboard(),
      },
    );
  }
}
