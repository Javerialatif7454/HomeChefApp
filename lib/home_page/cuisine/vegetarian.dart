import 'package:flutter/material.dart';
import '../../database_helper/add_to_cart.dart';
import '../../database_helper/cheken_tika.dart';
import '../../model/addtocart.dart';

class Vegetarian extends StatefulWidget {
  @override
  State<Vegetarian> createState() => _VegetarianState();
}

class _VegetarianState extends State<Vegetarian> {
  List<Map<String, String>> favoriteItems = [];

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

  final List<Map<String, String>> vegetarianItems = [
    {
      'image': 'assets/images/cuisine/vegetarian/Baingan_Bharta.jpeg',
      'description': 'A smoky eggplant dish, cooked with spices for a rich and tasty flavor. Goes well with bread or rice.',
      'title': 'Baingan Bharta',
      'price': 'Rs. 599',
      'deliveryTime': '10-15 min delivery',
    },
    {
      'image': 'assets/images/cuisine/vegetarian/Aloo_Gobi.jpeg',
      'description': 'A simple and tasty dish with potatoes and cauliflower, cooked with mild spices.',
      'title': 'Aloo Gobi',
      'price': 'Rs. 499',
      'deliveryTime': '10-15 min delivery',
    },
    {
      'image': 'assets/images/cuisine/vegetarian/Bhindi_Masala.jpeg',
      'description': 'A flavorful stir-fry of okra with spices, perfect with roti or rice.',
      'title': 'Bhindi Masala',
      'price': 'Rs. 399',
      'deliveryTime': '10-15 min delivery',
    },
    {
      'image': 'assets/images/cuisine/vegetarian/Methi_Thepla.jpeg',
      'description': 'A soft flatbread made with fenugreek and spices, great for breakfast or a snack.',
      'title': 'Methi Thepla',
      'price': 'Rs. 349',
      'deliveryTime': '10-15 min delivery',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vegetarian', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: vegetarianItems.map((item) {
            return VegetarianCardItem(
              imagePath: item['image']!,
              title: item['title']!,
              price: item['price']!,
              description: item['description']!,
              deliveryTime: item['deliveryTime']!,
              toggleFavorite: toggleFavorite,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class VegetarianCardItem extends StatefulWidget {
  final String imagePath;
  final String title;
  final String price;
  final String description;
  final String deliveryTime;
  final Function(String, String, String, bool) toggleFavorite;

  VegetarianCardItem({
    required this.imagePath,
    required this.title,
    required this.price,
    required this.description,
    required this.deliveryTime,
    required this.toggleFavorite,
  });

  @override
  _VegetarianCardItemState createState() => _VegetarianCardItemState();
}

class _VegetarianCardItemState extends State<VegetarianCardItem> {
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
                        builder: (context) => VegetarianDialog(
                          imagePath: widget.imagePath,
                          title: widget.title,
                          price: widget.price,
                          description: widget.description,
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

class VegetarianDialog extends StatelessWidget {
  final String imagePath;
  final String title;
  final String price;
  final String description;

  VegetarianDialog({
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
            SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add order functionality here
                },
                child: Text('Place Order', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                  backgroundColor: Color(0xff2C3E50), // Button color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
