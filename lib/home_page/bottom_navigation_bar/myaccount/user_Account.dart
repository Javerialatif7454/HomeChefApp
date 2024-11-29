import 'package:flutter/material.dart';
import 'package:newfyp/home_page/bottom_navigation_bar/myaccount/account_setting.dart';
import 'package:newfyp/home_page/bottom_navigation_bar/myaccount/profile.dart';
import 'package:newfyp/home_page/bottom_navigation_bar/myaccount/logout.dart';
import 'package:newfyp/home_page/bottom_navigation_bar/myaccount/privacy_policy.dart';
import 'package:newfyp/home_page/home2.dart';

class UserAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Account',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff2C3E50),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/girl5.jpeg'),
              ),
              SizedBox(height: 20),
              // User Information
              Text(
                'Javeria Latif',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff2C3E50),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Jia@gmail.com',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),
              // Action Buttons
              ActionButton(
                icon: Icons.edit,
                title: 'View Profile',
                iconColor: Color(0xff2C3E50),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profile(),
                    ));
                },
              ),
              ActionButton(
                icon: Icons.lock,
                title: 'Privacy Policy',
                iconColor: Color(0xff2C3E50), // Custom icon color
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),);
                },
              ),
              ActionButton(
                icon: Icons.logout,
                title: 'Log Out',
                iconColor: Color(0xff2C3E50), // Custom icon color
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LogoutPage()),);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// A reusable widget for action buttons
class ActionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color iconColor; // Add this parameter for the icon color

  ActionButton({
    required this.icon,
    required this.title,
    required this.onTap,
    this.iconColor = Colors.teal, // Default color for the icon
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          leading: Icon(icon, color: iconColor), // Use the iconColor parameter
          title: Text(title, style: TextStyle(fontSize: 18)),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
        ),
      ),
    );
  }
}
