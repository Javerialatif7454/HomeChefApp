import 'package:flutter/material.dart';
import 'package:newfyp/home_page/bottom_navigation_bar/add_to_cart.dart';
import '../../database_helper/add_to_cart.dart';
import '../../database_helper/cheken_tika.dart';
import '../../model/addtocart.dart';

class ChickenTikkaCard extends StatefulWidget {
  @override
  State<ChickenTikkaCard> createState() => _ChickenTikkaCardState();
}

class _ChickenTikkaCardState extends State<ChickenTikkaCard> {
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
      // Save to database
      await DBHelper.insertItem(imagePath, title, price);
    } else {
      // Optional: If needed, remove the item when unfavorite (handle as per your requirement)
      await DBHelper.deleteItem(imagePath); // Example of how you might handle removal
    }

    // Update UI
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
        title: Text('Chicken Tikka'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ChickenTikkaCardItem(
              imagePath: 'assets/images/cuisine/Chicken_tikka/Achari_Chicken_Tikka.jpeg',
              title: 'Achari Chicken Tikka',
              price: 'Rs. 1089',
              toggleFavorite: toggleFavorite,
            ),
            SizedBox(height: 10),
            ChickenTikkaCardItem(
              imagePath: 'assets/images/cuisine/Chicken_tikka/Classic_Chicken_Tikka.jpeg',
              title: 'Classic Chicken Tikka',
              price: 'Rs. 1240',
              toggleFavorite: toggleFavorite,
            ),
            SizedBox(height: 10),
            ChickenTikkaCardItem(
              imagePath: 'assets/images/cuisine/Chicken_tikka/Malai _Chicken_Tikka.jpeg',
              title: 'Malai Chicken Tikka',
              price: 'Rs. 1330',
              toggleFavorite: toggleFavorite,
            ),
            SizedBox(height: 10),
            ChickenTikkaCardItem(
              imagePath: 'assets/images/cuisine/Chicken_tikka/Spicy_Chicken_Tikka.jpeg',
              title: 'Spicy Chicken Tikka',
              price: 'Rs. 1165',
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
                        builder: (context) => ChickenTikkaDialouge(
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
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '10-15 min delivery',
                        style: TextStyle(
                          color: Colors.green[700],
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
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

class ChickenTikkaDialouge extends StatelessWidget {
  final String imagePath;
  final String title;
  final String price;

  ChickenTikkaDialouge({
    required this.imagePath,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    String description = '';
    if (title == 'Achari Chicken Tikka') {
      description = 'Achari Chicken Tikka is a tangy, flavorful delight made with authentic achari masala and grilled to perfection. ';
    } else if (title == 'Classic Chicken Tikka') {
      description = 'The Classic Chicken Tikka is a timeless recipe with perfectly marinated and grilled chicken pieces. ';
    } else if (title == 'Malai Chicken Tikka') {
      description = 'Malai Chicken Tikka is a creamy and mild-flavored dish made with a rich marinade of cream and spices. ';
    } else if (title == 'Spicy Chicken Tikka') {
      description = 'Spicy Chicken Tikka is a fiery treat for those who crave heat! ';
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
            Text(
              description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
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


