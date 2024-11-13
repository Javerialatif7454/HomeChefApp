import 'package:flutter/material.dart';
import 'package:newfyp/drawer/Our_chefs/Our_chefs.dart';

class Chef_Maham extends StatelessWidget {
  const Chef_Maham({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chef Profile',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
          centerTitle: true,
          leading: IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => OurChefs()),);
          },
              icon: Icon(Icons.arrow_back)),
          bottom: PreferredSize(preferredSize: const Size.fromHeight(20.0),
              child: Container(
                color: Colors.grey,
                height: 1.0,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 25,),
                Container(
                  height: 200,
                  width: 500,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: AssetImage('assets/images/chefs/chefw5.jpeg',
                          ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 7,),
                Column(
                  children: [
                    Container(
                      width: 500,
                      height: 280,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: ListView(
                        children: [
                          ListTile(
                            leading: IconButton(onPressed: (){},
                                icon: Icon(Icons.person)),
                            title: Text('Chef Name: ', style: TextStyle(fontWeight: FontWeight.bold),),
                            // trailing: ,
                          ),
                          Divider(),
                          ListTile(
                            leading: IconButton(onPressed: (){},
                                icon: Icon(Icons.email)),
                            title: Text('Email: Chef1@gamil.com', style: TextStyle(fontWeight: FontWeight.bold),),
                            // trailing: ,
                          ),
                          Divider(),
                          ListTile(
                            leading: IconButton(onPressed: (){},
                                icon: Icon(Icons.contact_mail)),
                            title: Text('Contact no:', style: TextStyle(fontWeight: FontWeight.bold),),

                            // trailing: ,
                          ),
                          Divider(),
                          ListTile(
                            leading: IconButton(onPressed: (){},
                                icon: Icon(Icons.details)),
                            title: Text('Experts In:', style: TextStyle(fontWeight: FontWeight.bold),),
                            // trailing: ,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
}

