import 'package:flutter/material.dart';
import 'package:newfyp/home_page/home2.dart';

import '../database_helper/signinup.dart';
import '../model/user.dart';
import 'button.dart';
import 'inputfield.dart';
import 'login.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final fullname = TextEditingController();
  final email = TextEditingController();
  final usrName = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final phoneNumber = TextEditingController(); // Controller for phone number
  bool isVisible = false;

  signUp() async {
    if (_formKey.currentState!.validate()) {
      if (password.text != confirmPassword.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match')),
        );
        return;
      }

      User newUser = User(
        username: usrName.text,
        fullname: fullname.text,
        email: email.text,
        password: password.text,
        phone: phoneNumber.text, // Add phone number to the user object
      );

      // Attempt to create a new user
      int userId = await DBHelper.createUser(newUser);

      if (userId == -1) {
        // Email already exists
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email is already in use')),
        );
        return;
      } else {
        // User created successfully, proceed with other initializations
        newUser.id = userId; // Assign the newly generated ID to the user object

        await DBHelper.saveUserData(newUser.email, newUser.password);
        // Initialize user-specific data if needed

        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(), // Navigate to homepage with user data
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Register New Account",
                      style: TextStyle(
                        color: Color(0xff2C3E50),
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  InputField(hint: "Full name", icon: Icons.person, controller: fullname),
                  InputField(hint: "Email", icon: Icons.email, controller: email, isEmail: true), // Email validation

                  InputField(hint: "Phone Number", icon: Icons.phone, controller: phoneNumber), // Phone number field
                  InputField(hint: "Password", icon: Icons.lock, controller: password, passwordInvisible: true),
                  InputField(hint: "Confirm Password", icon: Icons.lock, controller: confirmPassword, passwordInvisible: true),
                  const SizedBox(height: 10),
                  Button(label: "SIGN UP", press: signUp),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?", style: TextStyle(color: Color(0xff2C3E50))),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                        },
                        child: const Text("LOGIN"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
