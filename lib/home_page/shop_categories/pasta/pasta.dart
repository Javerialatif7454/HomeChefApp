import 'package:flutter/material.dart';
import 'package:newfyp/home_page/shop_categories/curry/curry.dart';

class PastaCard extends StatefulWidget {
  @override
  State<PastaCard> createState() => _PastaCardState();
}

class _PastaCardState extends State<PastaCard> {
  List<Map<String, String>> favoriteItems = [];

  void toggleFavorite(String imagePath, String title, String price, bool isFavorite) {
    setState(() {
      if (isFavorite) {
        favoriteItems.add({
          'imagePath': imagePath,
          'title': title,
          'price': price,
        });
      } else {
        favoriteItems.removeWhere((item) => item['imagePath'] == imagePath);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pasta '),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesPage(favoriteItems: favoriteItems),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PastaCardItem(
              imagePath: 'assets/images/shop_categories/pasta/Spaghetti Bolognese.jpeg',
              title: 'Spaghetti Pasta',
              price: '\$12.99',
              toggleFavorite: toggleFavorite,
            ),
            SizedBox(height: 10),
            PastaCardItem(
              imagePath: 'assets/images/shop_categories/pasta/Chicken Tikka Pasta.jpeg',
              title: 'Chicken Tikka Pasta',
              price: '\$10.99',
              toggleFavorite: toggleFavorite,
            ),
            SizedBox(height: 10),
            PastaCardItem(
              imagePath: 'assets/images/shop_categories/pasta/Mac and Cheese.jpeg',
              title: 'Mac and Cheese Pasta',
              price: '\$10.99',
              toggleFavorite: toggleFavorite,
            ),
            SizedBox(height: 10),
            PastaCardItem(
              imagePath: 'assets/images/shop_categories/pasta/Mutton Pasta.jpeg',
              title: 'Mutton Pasta',
              price: '\$10.99',
              toggleFavorite: toggleFavorite,
            ),
          ],
        ),
      ),
    );
  }
}

class PastaCardItem extends StatefulWidget {
  final String imagePath;
  final String title;
  final String price;
  final Function(String, String, String, bool) toggleFavorite;

  PastaCardItem({
    required this.imagePath,
    required this.title,
    required this.price,
    required this.toggleFavorite,
  });

  @override
  _PastaCardItemState createState() => _PastaCardItemState();
}

class _PastaCardItemState extends State<PastaCardItem> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 290,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.asset(
                    widget.imagePath,
                    width: 300,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isFavorite = !isFavorite;
                        widget.toggleFavorite(
                          widget.imagePath,
                          widget.title,
                          widget.price,
                          isFavorite,
                        );
                      });
                    },
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.yellow : Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.price,
              style: TextStyle(color: Colors.green),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Add to Cart'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
