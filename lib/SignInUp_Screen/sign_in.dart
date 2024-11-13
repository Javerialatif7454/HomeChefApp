import 'package:flutter/material.dart';
import 'package:newfyp/SignInUp_Screen/sign_up.dart';
import 'package:newfyp/home_page/home2.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../database_helper/database_helper.dart';

class Signin_Screen extends StatefulWidget {
  @override
  _Signin_ScreenState createState() => _Signin_ScreenState();
}

class _Signin_ScreenState extends State<Signin_Screen> {
  final _formKey = GlobalKey<FormState>();
  String? email, password;
  DatabaseHelper databaseHelper = DatabaseHelper.instance;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Map<String, dynamic>? user = await databaseHelper.getUser(email!);
      if (user != null && user['password'] == password) {
        // Save login state in shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
        prefs.setString('email', email!);

        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()),);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Invalid credentials")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Signin')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    label: Text('Email'),
                    border: InputBorder.none,
                    enabledBorder:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 2,
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 2,
                        )

                    )
                ),
                validator: (value) => value!.isEmpty ? 'Enter your email' : null,
                onSaved: (value) => email = value,
              ),
              SizedBox(height: 30,),
              TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    label: Text('Password'),
                    border: InputBorder.none,
                    enabledBorder:OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 2,
                        )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 2,
                        )

                    )
                ),
                obscureText: true,
                validator: (value) => value!.isEmpty ? 'Enter your password' : null,
                onSaved: (value) => password = value,
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: _login,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blueGrey
                    ),
                    child: Center(
                      child: Text(
                        'Signin',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?",style: TextStyle(fontSize: 15,)),
                  SizedBox(width: 2,),
                  GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
                      },
                      child: Text('SignUp',style: TextStyle(fontSize: 15)))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
