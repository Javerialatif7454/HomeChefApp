import 'package:flutter/material.dart';
import 'package:newfyp/drawer/Our_chefs/chefs/Chef_Huma.dart';
import 'package:newfyp/drawer/Our_chefs/chefs/Chef_Hadia.dart';
import 'package:newfyp/drawer/Our_chefs/chefs/Chef_Maham.dart';
import 'package:newfyp/drawer/Our_chefs/chefs/Chef_Zoya.dart';
import 'package:newfyp/drawer/Our_chefs/chefs/Chef_Laiba.dart';

class OurChefs extends StatelessWidget {
  const OurChefs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Our Chefs',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff2C3E50),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildChefCard(context, 'Huma Malik', 'assets/images/chefs/chefw1.png', Chef_Huma()),
            _buildChefCard(context, 'Hadia Zubair', 'assets/images/chefs/chefw2.jpeg', Chef_Hadia()),
            _buildChefCard(context, 'Maham Khan', 'assets/images/chefs/chefw3.jpeg', Chef_Maham()),
            _buildChefCard(context, 'Zoya Zohan', 'assets/images/chefs/chefw4.jpeg', Chef_Zoya()),
            _buildChefCard(context, 'Laiba Khalid', 'assets/images/chefs/chefw5.jpeg', Chef_Laiba()),
          ],
        ),
      ),
    );
  }

  Widget _buildChefCard(BuildContext context, String name, String imagePath, Widget chefPage) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(imagePath),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: const Text('Contact', style: TextStyle(fontSize: 14, color: Colors.grey)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.blue),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => chefPage),
          );
        },
      ),
    );
  }
}
