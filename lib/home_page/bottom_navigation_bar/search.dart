import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextFormField(
        decoration: InputDecoration(
          hintText: "Search",
          suffixIcon: IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Search()),);
          },
              icon: Icon(Icons.search)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
                width: 2,
                color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}
