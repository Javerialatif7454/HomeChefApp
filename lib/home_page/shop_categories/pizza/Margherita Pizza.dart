import 'package:flutter/material.dart';
import 'package:newfyp/database_helper/cheken_tika.dart';

import '../../../database_helper/add_to_cart.dart';
import '../../../model/addtocart.dart';

class PizzaCard extends StatefulWidget {
  @override
  State<PizzaCard> createState() => _PizzaCardState();
}

class _PizzaCardState extends State<PizzaCard> {
  List<Map<String, String>> favoriteItems = [];

  @override
  void initState() {
    super.initState();
    loadFavoriteItems();
  }

  Future<void> loadFavoriteItems() async {
    final items = await DBHelper.getItems();  // Load favorite items from DB
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
      // Save to database
      await DBHelper.insertItem(imagePath, title, price);
    } else {
      // Remove from database
      await DBHelper.deleteItem(imagePath);
    }

    // Update the UI
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

  // List of Pizza items with their details
  final List<Map<String, String>> pizzaItems = [
    {
      'image': 'assets/images/shop_categories/pizza/Cheese Lovers Pizza.jpeg',
      'description': 'Cheese Lovers Pizza',
      'price': 'Rs. 1200',
      'deliveryTime': '30-40 min delivery',
      'detailedDescription': 'A pizza for the cheese lover, loaded with different types of cheeses for a perfect cheesy bite!'
    },
    {
      'image': 'assets/images/shop_categories/pizza/chicken_tikka_pizza.jpeg',
      'description': 'Chicken Tikka Pizza',
      'price': 'Rs. 1100',
      'deliveryTime': '30-40 min delivery',
      'detailedDescription': 'A delicious pizza topped with tender chicken tikka, bursting with flavor.'
    },
    {
      'image': 'assets/images/shop_categories/pizza/Fajita Pizza.jpeg',
      'description': 'Fajita Pizza',
      'price': 'Rs. 1150',
      'deliveryTime': '30-40 min delivery',
      'detailedDescription': 'A spicy pizza with fajita vegetables, chicken, and a tangy sauce.'
    },
    {
      'image': 'assets/images/shop_categories/pizza/Margherita Pizza.jpeg',
      'description': 'Margherita Pizza',
      'price': 'Rs. 1050',
      'deliveryTime': '30-40 min delivery',
      'detailedDescription': 'A classic pizza with fresh mozzarella, basil, and a rich tomato sauce.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pizza', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: pizzaItems.map((item) {
            return PizzaCardItem(
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

class PizzaCardItem extends StatefulWidget {
  final String imagePath;
  final String title;
  final String price;
  final String deliveryTime;
  final String detailedDescription;
  final Function(String, String, String, bool) toggleFavorite;

  PizzaCardItem({
    required this.imagePath,
    required this.title,
    required this.price,
    required this.deliveryTime,
    required this.detailedDescription,
    required this.toggleFavorite,
  });

  @override
  _PizzaCardItemState createState() => _PizzaCardItemState();
}

class _PizzaCardItemState extends State<PizzaCardItem> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    loadFavoriteState();
  }

  Future<void> loadFavoriteState() async {
    final favorite = await DBHelper.isFavorite(widget.imagePath); // Check if item is favorite in DB
    setState(() {
      isFavorite = favorite;
    });
  }

  void addToCart() async {
    // Assuming quantity is 1 for now. You can modify it to increase based on user input.
    CartItem newItem = CartItem(
      imagePath: widget.imagePath,
      title: widget.title,
      price: widget.price,
      quantity: 1,  // Can be adjusted based on user input or selection
    );
    await DbHelper.insertCartItem(newItem);

    // Show a snack bar to notify the user
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('${widget.title} added to cart!'),
    ));
  }
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
                GestureDetector(
                  onTap: () {
                    // Navigate to the details page when image is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PizzaDialog(
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
                      width: 450,
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
                    onPressed: () {
                      addToCart();
                    },
                    child: Text('Add to Cart', style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 42, vertical: 15),
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

// Dialog for Pizza item details when the image is clicked
class PizzaDialog extends StatelessWidget {
  final String imagePath;
  final String title;
  final String price;
  final String description;

  PizzaDialog({
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
            Center(
              child: Image.asset(imagePath),
            ),
            SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              price,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20),
            Text(description),
            SizedBox(height: 20),
            // Center the "Place Order" button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Show a Snackbar to notify the user
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Order placed for $title!'),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        // Optional: Add undo functionality here if needed
                      },
                    ),
                  ));
                },
                child: Text('Place Order', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                  backgroundColor: Color(0xff2C3E50),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
