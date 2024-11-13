import 'package:flutter/material.dart';


class PizzaCard extends StatefulWidget {
  @override
  State<PizzaCard> createState() => _PizzaCardState();
}

class _PizzaCardState extends State<PizzaCard> {
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
        title: Text('Pizza '),
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
            PizzaCardItem(
              imagePath:'assets/images/shop_categories/pizza/Cheese Lovers Pizza.jpeg',
              title: 'Cheese Lovers Pizza',
              price: '\$15.99',
              toggleFavorite: toggleFavorite,
            ),
            SizedBox(height: 10),
            PizzaCardItem(
              imagePath: 'assets/images/shop_categories/pizza/chicken_tikka_pizza.jpeg',
              title: 'Chicken Tikka Pizza',
              price: '\$13.99',
              toggleFavorite: toggleFavorite,
            ),
            SizedBox(height: 10),
            PizzaCardItem(
              imagePath: 'assets/images/shop_categories/pizza/Fajita Pizza.jpeg',
              title: 'Fajita Pizza',
              price: '\$14.99',
              toggleFavorite: toggleFavorite,
            ),
            SizedBox(height: 10),
            PizzaCardItem(
              imagePath: 'assets/images/shop_categories/pizza/Margherita Pizza.jpeg',
              title: 'Margherita Pizza',
              price: '\$12.99',
              toggleFavorite: toggleFavorite,
            ),

          ],
        ),
      ),
    );
  }
}

class PizzaCardItem extends StatefulWidget {
  final String imagePath;
  final String title;
  final String price;
  final Function(String, String, String, bool) toggleFavorite;

  PizzaCardItem({
    required this.imagePath,
    required this.title,
    required this.price,
    required this.toggleFavorite,
  });

  @override
  _PizzaCardItemState createState() => _PizzaCardItemState();
}

class _PizzaCardItemState extends State<PizzaCardItem> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 320,
      child: Card(
        elevation: 5,

        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height:200,
                  padding:EdgeInsets.all(5),
                  child:
                  Image.asset(
                    widget.imagePath,
                    width: double.infinity,

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
            SizedBox(height: 4),
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


class FavoritesPage extends StatelessWidget {
  final List<Map<String, String>> favoriteItems;

  FavoritesPage({required this.favoriteItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: favoriteItems.isEmpty
          ? Center(child: Text('No favorites added.'))
          : ListView.builder(
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          final item = favoriteItems[index];
          return ListTile(
            leading: Image.asset(item['imagePath']!),
            title: Text(item['title']!),
            subtitle: Text(item['price']!),
          );
        },
      ),
    );
  }
}