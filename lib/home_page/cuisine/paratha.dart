import 'package:flutter/material.dart';
import 'package:newfyp/home_page/bottom_navigation_bar/add_to_cart.dart';
import '../../database_helper/add_to_cart.dart';
import '../../database_helper/cheken_tika.dart';
import '../../model/addtocart.dart';

class Paratha extends StatefulWidget {
  @override
  State<Paratha> createState() => _ParathaState();
}

class _ParathaState extends State<Paratha> {
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

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> parathaItems = [
      {
        'image': 'assets/images/cuisine/paratha/Keema_Paratha.jpeg',
        'title': 'Keema Paratha',
        'price': 'Rs. 699',
      },
      {
        'image': 'assets/images/cuisine/paratha/Aloo_Paratha.jpeg',
        'title': 'Aloo Paratha',
        'price': 'Rs. 499',
      },
      {
        'image': 'assets/images/cuisine/paratha/Methi_Paratha.jpeg',
        'title': 'Methi Paratha',
        'price': 'Rs. 599',
      },
      {
        'image': 'assets/images/cuisine/paratha/Gobi_Paratha.jpeg',
        'title': 'Gobi Paratha',
        'price': 'Rs. 799',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Paratha'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: parathaItems.map((item) {
            return ParathaCardItem(
              imagePath: item['image']!,
              title: item['title']!,
              price: item['price']!,
              toggleFavorite: toggleFavorite,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ParathaCardItem extends StatefulWidget {
  final String imagePath;
  final String title;
  final String price;
  final Function(String, String, String, bool) toggleFavorite;

  ParathaCardItem({
    required this.imagePath,
    required this.title,
    required this.price,
    required this.toggleFavorite,
  });

  @override
  _ParathaCardItemState createState() => _ParathaCardItemState();
}

class _ParathaCardItemState extends State<ParathaCardItem> {
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
                        builder: (context) => ParathaDialog(
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
                    onPressed: addToCart,
                    child: Text('Add to Cart', style: TextStyle(color: Colors.white)),
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

class ParathaDialog extends StatelessWidget {
  final String imagePath;
  final String title;
  final String price;

  ParathaDialog({
    required this.imagePath,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    String description = '';
    if (title == 'Keema Paratha') {
      description = 'A rich paratha stuffed with seasoned minced meat. A savory delight that’s crispy and flavorful.';
    } else if (title == 'Aloo Paratha') {
      description = 'A classic Indian paratha with spiced mashed potatoes. Perfectly soft and packed with traditional flavors.';
    } else if (title == 'Methi Paratha') {
      description = 'A healthy paratha made with fenugreek leaves. Lightly spiced for a delicious, earthy flavor.';
    } else if (title == 'Gobi Paratha') {
      description = 'A flavorful paratha filled with spiced cauliflower. A tasty and nutritious treat for all ages.';
    }


    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(imagePath),
            SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(price, style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text(description, style: TextStyle(fontSize: 16)),
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
