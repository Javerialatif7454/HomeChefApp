import 'package:flutter/material.dart';
import '../../../database_helper/signinup.dart';
import '../../../model/user.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? _user;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    Map<String, String>? userData = await DBHelper.getUserData();

    if (userData != null) {
      User? user = await DBHelper.getUserByEmail(userData['email']!);
      setState(() {
        _user = user;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),

      ),
      body: SingleChildScrollView(
        child: _user == null
            ? const Center(child: CircularProgressIndicator())
            : Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Profile Image
              Center(
                child: CircleAvatar(
                  radius: 50, // Adjust the radius as needed
                  backgroundColor: Colors.grey[300], // Placeholder background color
                  backgroundImage: AssetImage('assets/images/girl5.jpeg'),
                ),
              ),
              const SizedBox(height: 16),

              Center(
                child: Text(
                  _user?.email ?? "Email",
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 20),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.person_2, color: Color(0xff2C3E50)),
                title: const Text('Full Name'),
                subtitle: Text(_user?.fullname ?? "FullName"),
              ),

              ListTile(
                leading: const Icon(Icons.email, color: Color(0xff2C3E50)),
                title: const Text('Email'),
                subtitle: Text(_user?.email ?? "Email"),
              ),
              ListTile(
                leading: const Icon(Icons.password, color: Color(0xff2C3E50)),
                title: const Text('Password'),
                subtitle: Text(_user?.password ?? "Password"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

