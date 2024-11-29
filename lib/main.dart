import 'package:flutter/material.dart';
import 'package:newfyp/database_helper/signinup.dart';
import 'package:newfyp/drawer/Our_chefs/Our_chefs.dart';
import 'package:newfyp/drawer/Our_chefs/chefs/Chef_Huma.dart';
import 'package:newfyp/home_page/cuisine/chicken_tikka.dart';
import 'package:newfyp/home_page/fast_delivery/homemade_beef_biryani.dart';
import 'package:newfyp/home_page/home2.dart';
import 'package:newfyp/home_page/shop_categories/biryani/biryani.dart';
import 'package:newfyp/home_page/shop_categories/brownies/brownies.dart';
import 'package:newfyp/home_page/shop_categories/cake/cake.dart';
import 'package:newfyp/home_page/shop_categories/pasta/pasta.dart';
import 'package:newfyp/home_page/shop_categories/pizza/Margherita%20Pizza.dart';
import 'package:newfyp/drawer/side_bar.dart';
import 'package:newfyp/home_page/Explore_Offers.dart';
import 'package:newfyp/home_page/home2.dart';
import 'package:newfyp/view/Splash_Screen.dart';
void main(){
DBHelper dbHelper=DBHelper();
DBHelper.initDB();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home Chef Connect',
      theme: ThemeData(),
      home: Splash_Screen()
    );
  }
}


