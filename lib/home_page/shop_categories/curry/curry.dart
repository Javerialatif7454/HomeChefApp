import 'package:flutter/material.dart';
import 'package:newfyp/database_helper/cheken_tika.dart';

import '../../../database_helper/add_to_cart.dart';
import '../../../model/addtocart.dart'; // Import your DBHelper

class CurryCard extends StatefulWidget {
  @override
  State<CurryCard> createState() => _CurryCardState();
}

class _CurryCardState extends State<CurryCard> {
  List<Map<String, String>> favoriteItems = [];

  @override
  void initState() {
    super.initState();
    loadFavoriteItems();
  }

  Future<void> loadFavoriteItems() async {
    final items = await DBHelper.getItems(); // Load favorite items from DB
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
      await DBHelper.insertItem(imagePath, title, price); // Save to DB
    } else {
      await DBHelper.deleteItem(imagePath); // Remove from DB
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

  // List of Curry items with their details
  final List<Map<String, String>> curryItems = [
    {
      'image': 'assets/images/shop_categories/curry/karahi_Gosht.jpeg',
      'description': 'Karahi Gosht',
      'price': 'Rs. 1200',
      'deliveryTime': '30-40 min delivery',
    },
    {
      'image': 'assets/images/shop_categories/curry/butter_chicken.jpeg',
      'description': 'Butter Chicken',
      'price': 'Rs. 1000',
      'deliveryTime': '30-40 min delivery',
    },
    {
      'image': 'assets/images/shop_categories/curry/chiken_Tikka_masala.jpeg',
      'description': 'Chicken Tikka Masala',
      'price': 'Rs. 1100',
      'deliveryTime': '30-40 min delivery',
    },
    {
      'image': 'assets/images/shop_categories/curry/paneer_butter_masala.jpeg',
      'description': 'Paneer Butter Masala',
      'price': 'Rs. 950',
      'deliveryTime': '30-40 min delivery',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Curry', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: curryItems.map((item) {
            return CurryCardItem(
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

class CurryCardItem extends StatefulWidget {
  final String imagePath;
  final String title;
  final String price;
  final String deliveryTime;
  final Function(String, String, String, bool) toggleFavorite;

  CurryCardItem({
    required this.imagePath,
    required this.title,
    required this.price,
    required this.deliveryTime,
    required this.toggleFavorite,
  });

  @override
  _CurryCardItemState createState() => _CurryCardItemState();
}

class _CurryCardItemState extends State<CurryCardItem> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    loadFavoriteState();
  }

  Future<void> loadFavoriteState() async {
    final favorite = await DBHelper.isFavorite(widget.imagePath); // Check favorite in DB
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CurryDialog(
                          imagePath: widget.imagePath,
                          title: widget.title,
                          price: widget.price,
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
                  Expanded(  // Wrap the Column in Expanded to manage space
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                          ),
                          overflow: TextOverflow.ellipsis,  // Prevents overflow
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
                  ElevatedButton(
                    onPressed: () {
                      addToCart();
                    },
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(color: Colors.white),
                    ),
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

class CurryDialog extends StatelessWidget {
  final String imagePath;
  final String title;
  final String price;

  CurryDialog({
    required this.imagePath,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    // Define unique descriptions for each curry item
    String description = '';
    switch (imagePath) {
      case 'assets/images/shop_categories/curry/karahi_Gosht.jpeg':
        description = 'A spicy and flavorful mutton curry with a blend of aromatic spices.';
        break;
      case 'assets/images/shop_categories/curry/butter_chicken.jpeg':
        description = 'A creamy and rich chicken curry with a tomato-based sauce.';
        break;
      case 'assets/images/shop_categories/curry/chiken_Tikka_masala.jpeg':
        description = 'Tender chicken pieces cooked in a tangy, spiced, and creamy sauce.';
        break;
      case 'assets/images/shop_categories/curry/paneer_butter_masala.jpeg':
        description = 'A vegetarian delight made with cottage cheese in a rich tomato gravy.';
        break;
      default:
        description = 'A delicious curry made with the finest ingredients and spices.';
    }

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
