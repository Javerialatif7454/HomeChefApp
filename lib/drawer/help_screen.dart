import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2C3E50),
        title: Text(
          'Help & Support',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  'Welcome to Home Chef Connect!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff2C3E50),
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'If you need assistance, feel free to contact us at support@homechef.com.',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              Text(
                'Frequently Asked Questions:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff2C3E50)),
              ),
              Divider(),
              SizedBox(height: 10),
              _buildFAQ('1. How to place an order?',
                  'To place an order, simply browse through our menu, select items, and click "Add to Cart". Then proceed to checkout.'),
              _buildFAQ('2. How to manage my profile?',
                  'Go to the "Profile" section in the app where you can update your information and preferences.'),
              SizedBox(height: 20),

              _buildSection(
                'How to contact customer support:',
                'For any further assistance, you can reach us at support@homechef.com, or visit our website for more details.',
              ),
              SizedBox(height: 20),

              _buildSection(
                'About Us:',
                'Home Chef Connect is dedicated to bringing you the best home-cooked meals. We aim to connect chefs and customers in a seamless and enjoyable way.',
              ),
              SizedBox(height: 20),

              _buildSection(
                'Tips & Tricks:',
                'You can save your favorite dishes for easy access later, and enjoy discounts on your first order!',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAQ(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            answer,
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          Divider(),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff2C3E50)),
            ),
            SizedBox(height: 10),
            Text(
              content,
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
