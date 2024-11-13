import 'package:flutter/material.dart';
import 'package:newfyp/home_page/home2.dart';
class User_Account extends StatelessWidget {
  const User_Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile', style: TextStyle(color: Colors.white),),
          centerTitle: true,
          backgroundColor: Color(0xff2C3E50),
          leading: IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()),);
          },
              icon: Icon(Icons.arrow_back, color: Colors.white,)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage('assets/images/girl5.jpeg'),
                  ),
                ),
                SizedBox(height: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),)),
                    Text('Javeria Latif',style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),)
                  ],
                ),
                SizedBox(height: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Email', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),)),
                    Text('Jia@gmail.com',style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),)
                  ],
                ),
                SizedBox(height: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Phone', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),)),
                    Text('03012345678',style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),)
                  ],
                ),
                SizedBox(height: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Address', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),)),
                    Text('Allama Iqbal Town, Lahore',style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),)
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
}