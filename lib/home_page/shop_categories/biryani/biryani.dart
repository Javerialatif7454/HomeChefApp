import 'package:flutter/material.dart';
import 'package:newfyp/database_helper/cheken_tika.dart';

import '../../../database_helper/add_to_cart.dart';
import '../../../model/addtocart.dart';

class BiryaniCard extends StatefulWidget {
  @override
  State<BiryaniCard> createState() => _BiryaniCardState();
}

class _BiryaniCardState extends State<BiryaniCard> {
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

  // List of Biryani items with their details
  final List<Map<String, String>> biryaniItems = [
    {
      'image': 'assets/images/shop_categories/biryani/Lahori Biryani.jpeg',
      'description': 'Lahori Biryani',
      'price': 'Rs. 800',
      'deliveryTime': '40-50 min delivery',
      'itemDescription': 'A rich and spicy Lahori biryani made with tender chicken, spices, and saffron rice. A perfect treat for biryani lovers!'
    },
    {
      'image': 'assets/images/shop_categories/biryani/Chicken Biryani.jpeg',
      'description': 'Chicken Biryani',
      'price': 'Rs. 700',
      'deliveryTime': '40-50 min delivery',
      'itemDescription': 'A classic chicken biryani made with aromatic rice and marinated chicken, cooked to perfection with fragrant spices.'
    },
    {
      'image': 'assets/images/shop_categories/biryani/Beef Biryani.jpeg',
      'description': 'Beef Biryani',
      'price': 'Rs. 750',
      'deliveryTime': '40-50 min delivery',
      'itemDescription': 'Beef biryani made with slow-cooked tender beef, flavored with exotic spices, and served with basmati rice.'
    },
    {
      'image': 'assets/images/shop_categories/biryani/karachi_biryani.jpeg',
      'description': 'Karachi Biryani',
      'price': 'Rs. 780',
      'deliveryTime': '40-50 min delivery',
      'itemDescription': 'A spicy and flavorful biryani originating from Karachi, made with succulent meat and a blend of aromatic spices.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biryani', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: biryaniItems.map((item) {
            return BiryaniCardItem(
              imagePath: item['image']!,
              title: item['description']!,
              price: item['price']!,
              deliveryTime: item['deliveryTime']!,
              itemDescription: item['itemDescription']!,
              toggleFavorite: toggleFavorite,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class BiryaniCardItem extends StatefulWidget {
  final String imagePath;
  final String title;
  final String price;
  final String deliveryTime;
  final String itemDescription;
  final Function(String, String, String, bool) toggleFavorite;

  BiryaniCardItem({
    required this.imagePath,
    required this.title,
    required this.price,
    required this.deliveryTime,
    required this.itemDescription,
    required this.toggleFavorite,
  });

  @override
  _BiryaniCardItemState createState() => _BiryaniCardItemState();
}

class _BiryaniCardItemState extends State<BiryaniCardItem> {
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
                        builder: (context) => BiryaniDialog(
                          imagePath: widget.imagePath,
                          title: widget.title,
                          price: widget.price,
                          description: widget.itemDescription,
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
                  Expanded(
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
                  SizedBox(width: 5),
                  ElevatedButton(
                    onPressed: addToCart,
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

class BiryaniDialog extends StatelessWidget {
  final String imagePath;
  final String title;
  final String price;
  final String description;

  BiryaniDialog({
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
              child: Image.asset(
                imagePath,
                width: 250,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              price,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20),
            Text(
              description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Order placed for $title")),
                  );
                },
                child: Text("Place Order", style: TextStyle(color: Colors.white)),
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
