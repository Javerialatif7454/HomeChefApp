import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newfyp/home_page/bottom_navigation_bar/myaccount/user_account.dart'; // Import your UserAccountPage

class ExitScreen extends StatelessWidget {
  void _showLogoutDialog(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Exit App'),
            content: Text('Are you sure you want to exit the app?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);

                  SystemNavigator.pop();
                },
                child: Text('Exit'),
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
