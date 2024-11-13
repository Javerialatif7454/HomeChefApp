import 'package:flutter/material.dart';

class ChocolateCake extends StatelessWidget {
  const ChocolateCake({super.key});

  void toggleFavorite() {
    // Add your favorite action here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chocolate Cake")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            cakeCardItem('assets/images/shop_categories/cakes/Classic(One Bowl) Chocolate Cake.jpeg', 'Classic(One Bowl) Chocolate Cake', '\$12.99', toggleFavorite),
            SizedBox(height: 10),
            cakeCardItem('assets/images/shop_categories/cakes/Banana Cake.jpeg', 'Banana Cake', '\$10.99', toggleFavorite),
            SizedBox(height: 10),
            cakeCardItem('assets/images/shop_categories/cakes/Cherry_chocolate.jpeg', 'Cherry Chocolate', '\$10.99', toggleFavorite),
            SizedBox(height: 10),
            cakeCardItem('assets/images/shop_categories/cakes/Chocolate Truffle Cake.jpeg', 'Chocolate Truffle', '\$10.99', toggleFavorite),
          ],
        ),
      ),
    );
  }

  Widget cakeCardItem(String imagePath, String title, String price, VoidCallback toggleFavorite) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 135,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 15), // Space between image and text
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.timer, color: Colors.green, size: 16),
                            SizedBox(width: 5),
                            Text(
                              '10-15 mins',
                              style: TextStyle(fontSize: 12, color: Colors.green[700]),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Previous Price: $price',
                          style: TextStyle(fontSize: 12, color: Colors.grey, decoration: TextDecoration.lineThrough),
                        ),
                        SizedBox(height: 7),
                        SizedBox(
                          width: 168,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff2C3E50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.card_giftcard, color: Colors.white, size: 18),
                                SizedBox(width: 5),
                                Text(
                                  'Gift: Free Delivery',
                                  style: TextStyle(color: Colors.white, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(Icons.favorite_border, color: Colors.black),
                      onPressed: toggleFavorite,
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
