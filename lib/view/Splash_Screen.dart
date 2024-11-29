import 'dart:async';
import 'package:flutter/material.dart';
import 'package:newfyp/view/sign_up.dart';

import '../database_helper/signinup.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Splash_Screen(),
    );
  }
}

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});
  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  void initState() {
    super.initState();
    _checkUserStatus();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignupScreen()),
      );
    });
  }
  Future<void> _checkUserStatus() async {

    int numberOfUsers = await DBHelper.getUserCount();

    Future.delayed( const Duration(seconds: 1), () {
      if (numberOfUsers > 0) {
        // Navigate to LoginScreen if users exist
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ));
      } else {
        // Navigate to SignupScreen if no users exist
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const SignupScreen(),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              'assets/images/logo.jpeg',
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
