import 'package:flutter/material.dart';
import 'package:newfyp/database_helper/cheken_tika.dart';

import '../../../database_helper/add_to_cart.dart';
import '../../../model/addtocart.dart';

class BrowniesCard extends StatefulWidget {
  @override
  State<BrowniesCard> createState() => _BrowniesCardState();
}

class _BrowniesCardState extends State<BrowniesCard> {
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

  void toggleFavorite(String imagePath, String title, String price, bool isFavorite) async {
    if (isFavorite) {
      await DBHelper.insertItem(imagePath, title, price);
    } else {
      await DBHelper.deleteItem(imagePath);
    }

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

  final List<Map<String, String>> brownieItems = [
    {
      'image': 'assets/images/shop_categories/brownies/Walnut Brownies.jpeg',
      'description': 'Walnut Brownie',
      'price': 'Rs. 850',
      'deliveryTime': '15-20 min delivery',
      'detailedDescription': 'Our Walnut Brownie is a delightful treat, packed with the rich flavor of roasted walnuts and decadent chocolate. A perfect choice for nut lovers.'
    },
    {
      'image': 'assets/images/shop_categories/brownies/Nutella Brownies.jpeg',
      'description': 'Nutella Brownie',
      'price': 'Rs. 750',
      'deliveryTime': '15-20 min delivery',
      'detailedDescription': 'The Nutella Brownie is a rich, gooey chocolate brownie infused with Nutella, delivering an indulgent, melt-in-your-mouth experience.'
    },
    {
      'image': 'assets/images/shop_categories/brownies/Fudgy Brownies.jpeg',
      'description': 'Fudgy Brownie',
      'price': 'Rs. 800',
      'deliveryTime': '15-20 min delivery',
      'detailedDescription': 'Our Fudgy Brownie is the perfect balance of soft, rich chocolate and a slightly chewy texture. Ideal for true chocolate aficionados.'
    },
    {
      'image': 'assets/images/shop_categories/brownies/Classic Chocolate Brownies.jpeg',
      'description': 'Classic Chocolate Brownie',
      'price': 'Rs. 800',
      'deliveryTime': '15-20 min delivery',
      'detailedDescription': 'A timeless classic! Our Classic Chocolate Brownie is filled with deep, chocolatey goodness, topped with a slight crunch on the outside.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brownies', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: brownieItems.map((item) {
            return BrowniesCardItem(
              imagePath: item['image']!,
              title: item['description']!,
              price: item['price']!,
              deliveryTime: item['deliveryTime']!,
              detailedDescription: item['detailedDescription']!,
              toggleFavorite: toggleFavorite,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class BrowniesCardItem extends StatefulWidget {
  final String imagePath;
  final String title;
  final String price;
  final String deliveryTime;
  final String detailedDescription;
  final Function(String, String, String, bool) toggleFavorite;

  BrowniesCardItem({
    required this.imagePath,
    required this.title,
    required this.price,
    required this.deliveryTime,
    required this.detailedDescription,
    required this.toggleFavorite,
  });

  @override
  _BrowniesCardItemState createState() => _BrowniesCardItemState();
}

class _BrowniesCardItemState extends State<BrowniesCardItem> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    loadFavoriteState();
  }

  Future<void> loadFavoriteState() async {
    final favorite = await DBHelper.isFavorite(widget.imagePath);
    setState(() {
      isFavorite = favorite;
    });
  }

  void addToCart() async {
    CartItem newItem = CartItem(
      imagePath: widget.imagePath,
      title: widget.title,
      price: widget.price,
      quantity: 1,
    );
    await DbHelper.insertCartItem(newItem);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('${widget.title} added to cart!'),
    ));
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 280,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BrownieDialog(
                          imagePath: widget.imagePath,
                          title: widget.title,
                          price: widget.price,
                          description: widget.detailedDescription,
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.asset(
                      widget.imagePath,
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
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
                  Expanded( // Wrap text in an Expanded widget to avoid overflow
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
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
                  ),
                  SizedBox(width: 5), // Add spacing between text and button
                  ElevatedButton(
                    onPressed: () {
                      addToCart();
                    },
                    child: Text('Add to Cart', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 42, vertical: 15),
                      backgroundColor: Color(0xff2C3E50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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

class BrownieDialog extends StatelessWidget {
  final String imagePath;
  final String title;
  final String price;
  final String description;

  BrownieDialog({
    required this.imagePath,
    required this.title,
    required this.price,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center( // Center the image
              child: Image.asset(
                imagePath,
                width: 250, // You can adjust the size as needed
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(price, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            SizedBox(height: 20),
            Text(description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20), // Add space before the button
            Center( // Center the button
              child: ElevatedButton(
                onPressed: () {
                  // Add functionality for placing an order here
                  // For example, navigate to an order confirmation page or show a snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Order placed for $title")),
                  );
                },
                child: Text("Place Order", style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 42, vertical: 15),
                  backgroundColor: Color(0xff2C3E50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

