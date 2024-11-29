import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2C3E50),
        title: Text('Terms and Conditions', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Text(
              'Terms and Conditions',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff2C3E50)),
            ),
            SizedBox(height: 20),
            Text(
              '1. Introduction',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff2C3E50)),
            ),
            SizedBox(height: 10),
            Text(
              'Welcome to our application. By using our app, you agree to these terms and conditions. Please read them carefully.',
              style: TextStyle(fontSize: 16, color: Color(0xff2C3E50)),
            ),
            SizedBox(height: 20),
            Text(
              '2. User Responsibilities',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff2C3E50)),
            ),
            SizedBox(height: 10),
            Text(
              'You agree to use the app in accordance with the applicable laws and regulations. Any misuse of the app will result in termination of your access.',
              style: TextStyle(fontSize: 16, color: Color(0xff2C3E50)),
            ),
            SizedBox(height: 20),
            Text(
              '3. Privacy Policy',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff2C3E50)),
            ),
            SizedBox(height: 10),
            Text(
              'We respect your privacy. For more details on how we collect and use your data, please refer to our Privacy Policy.',
              style: TextStyle(fontSize: 16, color: Color(0xff2C3E50)),
            ),
            SizedBox(height: 20),
            Text(
              '4. Termination of Services',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff2C3E50)),
            ),
            SizedBox(height: 10),
            Text(
              'We reserve the right to terminate your access to the app at any time without prior notice if we believe you have violated these terms.',
              style: TextStyle(fontSize: 16, color: Color(0xff2C3E50)),
            ),
            SizedBox(height: 20),
            Text(
              '5. Limitation of Liability',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff2C3E50)),
            ),
            SizedBox(height: 10),
            Text(
              'We are not liable for any damages arising from the use of our app. Use the app at your own risk.',
              style: TextStyle(fontSize: 16, color: Color(0xff2C3E50)),
            ),
            SizedBox(height: 20),
            Text(
              '6. Changes to Terms',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff2C3E50)),
            ),
            SizedBox(height: 10),
            Text(
              'We reserve the right to update or modify these terms at any time. Any changes will be posted on this page.',
              style: TextStyle(fontSize: 16, color: Color(0xff2C3E50)),
            ),
            SizedBox(height: 20),
            Text(
              '7. Contact Us',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff2C3E50)),
            ),
            SizedBox(height: 10),
            Text(
              'If you have any questions about these terms and conditions, please contact us at HomeChefConnect@gmail.com.',
              style: TextStyle(fontSize: 16, color: Color(0xff2C3E50)),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
