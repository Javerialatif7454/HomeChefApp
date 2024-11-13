import 'package:flutter/material.dart';

class ChickenTikkaPizza extends StatelessWidget {
  const ChickenTikkaPizza({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chicken Tikka Pizza")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dealContainer('assets/images/shop_categories/pizza/chicken_tikka_pizza.jpeg', 'Chicken tikka pizza', '\$12.99'),
            dealContainer('assets/images/shop_categories/curry/butter_chicken.jpeg', 'Butter Chicken', '\$13.99'),
            dealContainer('assets/images/shop_categories/curry/chiken_Tikka_masala.jpeg', 'Chicken Tikka Masala', '\$14.99'),
            dealContainer('assets/images/shop_categories/curry/mutton_karahi.jpeg', 'Mutton Karahi', '\$15.99'),
            dealContainer('assets/images/shop_categories/curry/karahi_Gosht.jpeg', 'Karahi Gosht', '\$16.99'),
          ],
        ),
      ),
    );
  }

  Widget dealContainer(String imagePath, String productName, String price) {
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

            // Text on the right side
            SizedBox(width: 10),

            // Text and details with favorite icon overlay
            Expanded(
              child: Stack(
                children: [
                  // Content Column
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Product name
                        Text(
                          productName,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5),

                        // Delivery time with timer icon
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

                        // Previous price
                        Text(
                          'Previous Price: $price',
                          style: TextStyle(fontSize: 12, color: Colors.grey, decoration: TextDecoration.lineThrough),
                        ),
                        SizedBox(height: 7),

                        // Button with gift icon and "Free Delivery" text
                        SizedBox(
                          width: 168,  // Desired width
                          height: 40,  // Desired height
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

                  // Favorite Icon
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(Icons.favorite_border, color: Colors.black),
                      onPressed: () {
                        // Add your favorite action here
                      },
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
