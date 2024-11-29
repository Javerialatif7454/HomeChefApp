import 'package:flutter/material.dart';
import '../../database_helper/add_to_cart.dart';
import '../../database_helper/cheken_tika.dart';
import '../../model/addtocart.dart';

class Haleem extends StatefulWidget {
  @override
  State<Haleem> createState() => _HaleemCardState();
}

class _HaleemCardState extends State<Haleem> {
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

  final List<Map<String, String>> haleemItems = [
    {
      'image': 'assets/images/cuisine/haleem/Beef_Haleem.jpeg',
      'description': 'Beef Haleem',
      'price': 'Rs. 999',
      'deliveryTime': '10-15 min delivery',
    },
    {
      'image': 'assets/images/cuisine/haleem/Chicken_Haleem.jpeg',
      'description': 'Chicken Haleem',
      'price': 'Rs. 899',
      'deliveryTime': '10-15 min delivery',
    },
    {
      'image': 'assets/images/cuisine/haleem/Mutton_Haleem.jpeg',
      'description': 'Mutton Haleem',
      'price': 'Rs. 1099',
      'deliveryTime': '10-15 min delivery',
    },
    {
      'image': 'assets/images/cuisine/haleem/Shahi_Haleem.jpeg',
      'description': 'Shahi Haleem',
      'price': 'Rs. 799',
      'deliveryTime': '10-15 min delivery',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Haleem', style: TextStyle(fontWeight: FontWeight.bold)),
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
                        builder: (context) => HaleemDialog(
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

class HaleemDialog extends StatelessWidget {
  final String imagePath;
  final String title;
  final String price;

  HaleemDialog({
    required this.imagePath,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    String description = '';
    if (title == 'Beef Haleem') {
      description = 'Beef Haleem is a hearty, rich dish made with tender beef and spices.';
    } else if (title == 'Chicken Haleem') {
      description = 'Chicken Haleem is a warm, spicy dish made with chicken and a blend of flavorful spices.';
    } else if (title == 'Mutton Haleem') {
      description = 'Mutton Haleem is made with succulent mutton pieces and slow-cooked to perfection.';
    } else if (title == 'Shahi Haleem') {
      description = 'Shahi Haleem is a royal delicacy, a blend of spices, meat, and grains cooked together.';
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
