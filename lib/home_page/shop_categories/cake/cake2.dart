import 'package:flutter/material.dart';
class Cake1 extends StatelessWidget {
  const Cake1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cakes'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage('assets/images/cake/Banana Cake.jpeg'),
                      fit: BoxFit.cover)
              ),
            ),
            Column(
              children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('strawberry flavour', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    )),
                Row(
                  children: [
                    Text('Price: ', style: TextStyle(fontWeight: FontWeight.w600),),
                    Text('1500', style: TextStyle(fontWeight: FontWeight.w400),),
                  ],
                ),
                Text('Location: ', style: TextStyle(fontWeight: FontWeight.w600),),
                Text('Allama Iqbal Town,Lahore', style: TextStyle(fontWeight: FontWeight.w400),),
              ],
            )
          ],
        ),
      ),

    );
  }
}
