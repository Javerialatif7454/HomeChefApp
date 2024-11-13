import 'package:flutter/material.dart';
import 'package:newfyp/SignInUp_Screen/sign_in.dart';
import 'package:newfyp/home_page/home2.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../database_helper/database_helper.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String? name, email, password, confirmPassword;
  DatabaseHelper databaseHelper = DatabaseHelper.instance;

  Future<void> _signup() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Passwords do not match")),
        );
        return;
      }

      Map<String, dynamic>? user = await databaseHelper.getUser(email!);
      if (user == null) {
        // Insert new user data into database
        await databaseHelper.insert({
          'name': name,
          'email': email,
          'password': password,
        });

        // Save login state in shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
        prefs.setString('email', email!);

        Navigator.pushReplacementNamed(context, 'home_page');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User already exists")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    label: Text('Name'),
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
                validator: (value) => value!.isEmpty ? 'Enter your name' : null,
                onSaved: (value) => name = value,
              ),
              SizedBox(height: 10,),

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
                ),                validator: (value) => value!.isEmpty ? 'Enter your email' : null,
                onSaved: (value) => email = value,
              ),
              SizedBox(height: 10,),

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
                ),                obscureText: true,
                validator: (value) => value!.isEmpty ? 'Enter your password' : null,
                onSaved: (value) => password = value,
              ),
              SizedBox(height: 10,),
              TextFormField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    label: Text('Comfirm Password'),
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
                ),                obscureText: true,
                validator: (value) => value!.isEmpty ? 'Confirm your password' : null,
                onSaved: (value) => confirmPassword = value,
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: _signup,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()), // Replace `HomePage` with your actual homepage widget
                      );
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.blueGrey,
                      ),
                      child: Center(
                        child: Text(
                          'Signup',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  )

                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Allready have an account?",style: TextStyle(fontSize: 15,)),
                  SizedBox(width: 2,),
                  GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                      },
                      child: Text('SignInUp_Screen',style: TextStyle(fontSize: 15)))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
