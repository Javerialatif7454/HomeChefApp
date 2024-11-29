import 'package:flutter/material.dart';
import 'package:newfyp/drawer/setting/feedback&support.dart';
import 'package:newfyp/drawer/setting/rate_us.dart';
import 'package:newfyp/drawer/setting/terms&conditions.dart';
import 'package:newfyp/home_page/bottom_navigation_bar/myaccount/account_setting.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2C3E50),
        title: Text('Settings', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            // Account Information Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(Icons.account_circle, color: Color(0xff2C3E50)),
                title: Text('Account Information'),
                subtitle: Text('Update your account details'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AccountSettingsPage()),);
                },
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(Icons.star_rate, color: Color(0xff2C3E50)),
                title: Text('Rate us'),
                subtitle: Text('Rate the app '),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RateUsPage()),);

                },
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(Icons.feedback, color: Color(0xff2C3E50)),
                title: Text('Feedback & Support'),
                subtitle: Text('Give feedback or get help'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackSupportPage()),);
                },
              ),
            ),
            SizedBox(height: 20),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(Icons.article, color: Color(0xff2C3E50)),
                title: Text('Terms and Conditions'),
                subtitle: Text('Read the app\'s terms and conditions'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TermsAndConditionsPage()),);
                },
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
