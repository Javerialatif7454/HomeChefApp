import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newfyp/home_page/home2.dart';
import 'package:newfyp/model/user.dart';
import 'package:newfyp/view/sign_up.dart';

import '../database_helper/signinup.dart';
import 'button.dart';
import 'inputfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  // Our controllers
  final password = TextEditingController();
  final email = TextEditingController();

  bool isChecked = true;
  bool isLoginTrue = false;
  bool isEmailRegistered = true;

  late Future<void> _lottieFuture;

  @override
  void initState() {
    super.initState();
    _checkRememberMe();
    _lottieFuture = _preloadLottie();
  }

  // Preload Lottie animation
  Future<void> _preloadLottie() async {
    await Future.delayed(Duration.zero); // Simulate a delay for loading
  }

  // Check if user is remembered
  _checkRememberMe() async {
    final userData = await DBHelper.getUserData();
    if (userData != null) {
      email.text = userData['email']!;
      password.text = userData['password']!;
      login();
    }
  }

  // Login Method
  login() async {
    if (_formKey.currentState!.validate()) {
      User? usrDetails = await DBHelper.getUserByEmail(email.text);
      if (usrDetails == null) {
        setState(() {
          isEmailRegistered = false;
          isLoginTrue = false;
        });
        return;
      } else {
        setState(() {
          isEmailRegistered = true;
        });
      }


      var res = await DBHelper.authenticate(User(password: password.text, email: email.text));
      if (res == true) {
        if (isChecked) {
          await DBHelper.saveUserData(email.text, password.text);
        } else {
          await DBHelper.clearUserData();
        }
        try {

        } catch (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to initialize task database. Please try again.')),
          );
          return;
        }

        // Check if the onboarding page has been shown

          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(), // Navigate to homepage directly
            ),
          );
        }
      } else {
        setState(() {
          isLoginTrue = true;
        });
      }
    }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: FutureBuilder(
              future: _lottieFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("LOGIN", style: TextStyle(color: Color(0xff2C3E50), fontSize: 40)),

                        InputField(hint: "Email", icon: Icons.email, controller: email, isEmail: true),
                        InputField(hint: "Password", icon: Icons.lock, controller: password, passwordInvisible: true),
                        
                        Button(label: "LOGIN", press: login),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?", style: TextStyle(color: Colors.grey)),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignupScreen()));
                              },
                              child: const Text("SIGN UP"),
                            ),
                          ],
                        ),
                        if (!isEmailRegistered)
                          Text("Email is not registered", style: TextStyle(color: Colors.red.shade900)),
                        if (isLoginTrue)
                          Text("Password is incorrect", style: TextStyle(color: Colors.red.shade900)),
                      ],
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}