import 'package:flutter/material.dart';

class ChickenTikkaCard extends StatefulWidget {
  @override
  State<ChickenTikkaCard> createState() => _ChickenTikkaCardState();
}

class _ChickenTikkaCardState extends State<ChickenTikkaCard> {
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
        title: Text('Chicken Tikka', style: TextStyle(fontWeight: FontWeight.bold),),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              // Add your favorite page navigation here
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ChickenTikkaCardItem(
              imagePath: 'assets/images/cuisine/Chicken_tikka/Achari_Chicken_Tikka.jpeg',
              title: 'Achari Chicken Tikka',
              price: '\$12.99',
              toggleFavorite: toggleFavorite,
            ),
            SizedBox(height: 10),
            ChickenTikkaCardItem(
              imagePath: 'assets/images/cuisine/Chicken_tikka/Classic_Chicken_Tikka.jpeg',
              title: 'Classic Chicken Tikka',
              price: '\$14.99',
              toggleFavorite: toggleFavorite,
            ),
            SizedBox(height: 10),
            ChickenTikkaCardItem(
              imagePath: 'assets/images/cuisine/Chicken_tikka/Malai _Chicken_Tikka.jpeg',
              title: 'Malai Chicken Tikka',
              price: '\$15.99',
              toggleFavorite: toggleFavorite,
            ),
            SizedBox(height: 10),
            ChickenTikkaCardItem(
              imagePath: 'assets/images/cuisine/Chicken_tikka/Spicy_Chicken_Tikka.jpeg',
              title: 'Spicy Chicken Tikka',
              price: '\$13.99',
              toggleFavorite: toggleFavorite,
            ),
          ],
        ),
      ),
    );
  }
}

class ChickenTikkaCardItem extends StatefulWidget {
  final String imagePath;
  final String title;
  final String price;
  final Function(String, String, String, bool) toggleFavorite;

  ChickenTikkaCardItem({
    required this.imagePath,
    required this.title,
    required this.price,
    required this.toggleFavorite,
  });

  @override
  _ChickenTikkaCardItemState createState() => _ChickenTikkaCardItemState();
}

class _ChickenTikkaCardItemState extends State<ChickenTikkaCardItem> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 270,
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
                    width: 450,
                    height: 180,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left side text: Title, Price, and Delivery Time
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        widget.price,
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '10-15 min delivery',
                        style: TextStyle(color: Colors.green[700], fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  // Right side: Add to Cart button
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Add to Cart', style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff2C3E50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
