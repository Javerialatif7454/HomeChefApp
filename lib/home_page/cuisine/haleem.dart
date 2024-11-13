import 'package:flutter/material.dart';

class Haleem extends StatefulWidget {
  @override
  State<Haleem> createState() => _HaleemCardState();
}

class _HaleemCardState extends State<Haleem> {
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

  // List of Haleem items with their details
  final List<Map<String, String>> haleemItems = [
    {
      'image': 'assets/images/cuisine/haleem/Beef_Haleem.jpeg',
      'description': 'Beef Haleem',
      'price': '\$13.99',
      'deliveryTime': '10-15 min delivery',
    },
    {
      'image': 'assets/images/cuisine/haleem/Chicken_Haleem.jpeg',
      'description': 'Chicken Haleem',
      'price': '\$12.99',
      'deliveryTime': '10-15 min delivery',
    },
    {
      'image': 'assets/images/cuisine/haleem/Mutton_Haleem.jpeg',
      'description': 'Mutton Haleem',
      'price': '\$14.99',
      'deliveryTime': '10-15 min delivery',
    },
    {
      'image': 'assets/images/cuisine/haleem/Shahi_Haleem.jpeg',
      'description': 'Shahi Haleem',
      'price': '\$11.99',
      'deliveryTime': '10-15 min delivery',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Haleem', style: TextStyle(fontWeight: FontWeight.bold),),
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
          children: haleemItems.map((item) {
            return HaleemCardItem(
              imagePath: item['image']!,
              title: item['description']!,
              price: item['price']!,
              deliveryTime: item['deliveryTime']!,
              toggleFavorite: toggleFavorite,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class HaleemCardItem extends StatefulWidget {
  final String imagePath;
  final String title;
  final String price;
  final String deliveryTime;
  final Function(String, String, String, bool) toggleFavorite;

  HaleemCardItem({
    required this.imagePath,
    required this.title,
    required this.price,
    required this.deliveryTime,
    required this.toggleFavorite,
  });

  @override
  _HaleemCardItemState createState() => _HaleemCardItemState();
}

class _HaleemCardItemState extends State<HaleemCardItem> {
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
                        widget.deliveryTime,
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
