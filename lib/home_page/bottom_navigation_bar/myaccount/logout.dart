import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfyp/home_page/bottom_navigation_bar/myaccount/user_account.dart';

class LogoutPage extends StatelessWidget {
  void _showLogoutDialog(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Log Out'),
            content: Text('Are you sure you want to log out?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => UserAccountPage()),
                  );
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  SystemNavigator.pop();
                },
                child: Text('Log Out'),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    _showLogoutDialog(context);

    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Optionally show a loader until the dialog is displayed
      ),
    );
  }
}
