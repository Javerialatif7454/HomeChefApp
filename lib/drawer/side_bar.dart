// import 'package:final_home_chef_connect/Home_Main.dart';
import 'package:flutter/material.dart';
import 'package:newfyp/drawer/Our_chefs/Our_chefs.dart';
import 'package:newfyp/drawer/exit_screen.dart';
import 'package:newfyp/drawer/favorites.dart';
import 'package:newfyp/drawer/help_screen.dart';
import 'package:newfyp/drawer/setting/setting.dart';
import 'package:newfyp/home_page/bottom_navigation_bar/add_to_cart.dart';
import 'package:newfyp/home_page/home2.dart';

import '../home_page/bottom_navigation_bar/myaccount/cart.dart';
class Side_Bar extends StatelessWidget {
  const Side_Bar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Hcc'),
            accountEmail: Text('HomeChefConnect@gmail.com'),
            currentAccountPicture: ClipOval(
              child: CircleAvatar(
                child: Image.asset('assets/images/logo.jpeg',
                  // fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Color(0xff2C3E50)
                // image: DecorationImage(
                //     image: AssetImage('assets/images/currycurry/karahi_Gosht.jpeg'),
                //     fit: BoxFit.cover
                // )
            ),
          ),
          ListTile(
            leading: Icon(Icons.home,),
            title: Text('Home'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()),);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favorite'),
             onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritesPage()),);
             },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Shopping List'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()),);
            }
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.restaurant),
            title: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => OurChefs()),);
            },
              child: Text('Our Chefs'),),),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()),);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HelpScreen()),);
            }
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Exit'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ExitScreen()),);
            },
          ),
        ],
      ),
    );
  }
}


