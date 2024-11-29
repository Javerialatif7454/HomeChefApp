import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../database_helper/cheken_tika.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Map<String, dynamic>> _items = []; // Store items from DB
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadItems(); // Load items from the database when the screen is initialized
  }

  // Load all items from the database
  Future<void> _loadItems() async {
    final items = await DBHelper.getItems(); // Fetch items from DB
    setState(() {
      _items = items; // Update the state with fetched items
    });
  }

  // Filter items based on search query
  List<Map<String, dynamic>> _filterItems(String query) {
    return _items.where((item) {
      return item['title'].toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
          ),
          onChanged: (query) {
            setState(() {
              _items = _filterItems(query); // Update the displayed items based on search query
            });
          },
        ),
        centerTitle: true,
        backgroundColor: Color(0xff2C3E50),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
              setState(() {
                _items = _filterItems(''); // Reset the list when search is cleared
              });
            },
          ),
        ],
      ),
      body: _items.isEmpty
          ? Center(child: CircularProgressIndicator()) // Show loading while items are being fetched
          : ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];
          return ListTile(
            leading: Image.asset(item['imagePath']), // Display image from item
            title: Text(item['title']),
            subtitle: Text('Price: ${item['price']}'),
          );
        },
      ),
    );
  }
}
