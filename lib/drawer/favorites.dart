import 'package:flutter/material.dart';
import 'package:newfyp/home_page/home2.dart';
import '../database_helper/cheken_tika.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Map<String, String>> favoriteItems = [];

  @override
  void initState() {
    super.initState();
    loadFavoriteItems();
  }

  Future<void> loadFavoriteItems() async {
    final items = await DBHelper.getItems();
    setState(() {
      favoriteItems = items
          .map((item) => {
        'imagePath': item['imagePath'] as String,
        'title': item['title'] as String,
        'price': item['price'] as String,
      })
          .toList();
    });
  }

  Future<void> removeFromFavorites(String imagePath) async {
    await DBHelper.deleteItem(imagePath);
    loadFavoriteItems();
  }

  Future<bool?> showDeleteConfirmationDialog(String imagePath, String title) async {
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to remove "$title" from favorites?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // User cancels deletion
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // User confirms deletion
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
      ),
      body: favoriteItems.isEmpty
          ? Center(
        child: Text('No favorite items added yet!'),
      )
          : ListView.builder(
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          final item = favoriteItems[index];
          return Dismissible(
            key: Key(item['imagePath']!),
            direction: DismissDirection.endToStart,
            confirmDismiss: (direction) async {
              final shouldDelete = await showDeleteConfirmationDialog(
                  item['imagePath']!, item['title']!);
              if (shouldDelete == true) {
                await removeFromFavorites(item['imagePath']!);
                return true; // Allow the dismissal
              } else {
                return false; // Cancel the dismissal
              }
            },
            background: Container(
              color: Colors.red,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
            child: Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                leading: Image.asset(
                  item['imagePath']!,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
                title: Text(item['title']!),
                subtitle: Text(item['price']!),
              ),
            ),
          );
        },
      ),
    );
  }
}
