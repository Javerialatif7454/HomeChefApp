import 'package:flutter/material.dart';
import 'package:newfyp/drawer/Our_chefs/chefs/Chef_Huma.dart';
import 'package:newfyp/drawer/Our_chefs/chefs/Chef_Hadia.dart';
import 'package:newfyp/drawer/Our_chefs/chefs/Chef_Maham.dart';
import 'package:newfyp/drawer/Our_chefs/chefs/Chef_Zoya.dart';
import 'package:newfyp/drawer/Our_chefs/chefs/Chef_Laiba.dart';
import 'package:newfyp/home_page/home2.dart';

class OurChefs extends StatelessWidget {
  const OurChefs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Our Chefs', style: TextStyle(color: Colors.white),),
        // bottom: PreferredSize(preferredSize: const Size.fromHeight(20.0),
        //     child: Container(
        //       color: Colors.grey,
        //       height: 1.0,
        //     )),
        centerTitle: true,
        backgroundColor: Color(0xff2C3E50),
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()),);
        },
            icon: Icon(Icons.arrow_back, color: Colors.white,)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            height: 550,
            width: 600,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              // color: Color(0xFFB0C4DE) ,
            ),
            child: ListView(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/chefs/chefw1.png'),
                  ),
                  title: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Chef_Huma()),);
                      },
                      child: Text('Huma Malik', style: TextStyle(fontWeight: FontWeight.w800),)),
                  subtitle: Text('Contact'),
                  trailing: Icon(Icons.add),
                ),
                Divider(),
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/chefs/chefw2.jpeg'),
                  ),
                  title: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Chef_Hadia()),);
                      },
                      child: Text('Hadia Zubair', style: TextStyle(fontWeight: FontWeight.w800),)),
                  subtitle: Text('Contact'),
                  trailing: Icon(Icons.add),
                ),
                Divider(),
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/chefs/chefw3.jpeg'),
                  ),
                  title: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Chef_Maham()),);
                      },
                      child: Text('Maham Khan', style: TextStyle(fontWeight: FontWeight.w800),)),
                  subtitle: Text('Contact'),
                  trailing: Icon(Icons.add),
                ),
                Divider(),
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/chefs/chefw4.jpeg'),
                  ),
                  title: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Chef_Zoya()),);
                      },
                      child: Text('Zoya Zohan', style: TextStyle(fontWeight: FontWeight.w800),)),
                  subtitle: Text('Contact'),
                  trailing: Icon(Icons.add),
                ),
                Divider(),
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/chefs/chefw5.jpeg'),
                  ),
                  title: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Chef_Laiba()),);
                      },
                      child: Text('Laiba Khalid', style: TextStyle(fontWeight: FontWeight.w800),)),
                  subtitle: Text('Contact'),
                  trailing: Icon(Icons.add),
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

