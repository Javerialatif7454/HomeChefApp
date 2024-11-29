import 'package:flutter/material.dart';
import '../../database_helper/add_to_cart.dart';
import '../../model/addtocart.dart'; //
import '../../database_helper/cheken_tika.dart';

class SeekhKabab extends StatefulWidget {
  @override
  State<SeekhKabab> createState() => _SeekhKababCardState();
}

class _SeekhKababCardState extends State<SeekhKabab> {
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
        favoriteItems.add({'imagePath': imagePath, 'title': title, 'price': price});
      } else {
        favoriteItems.removeWhere((item) => item['imagePath'] == imagePath);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> seekhKababItems = [
      {
        'image': 'assets/images/cuisine/seekh_kabab/beef_seekh_kabab.jpeg',
        'description': 'Beef Seekh Kabab',
        'price': 'Rs. 899',
        'deliveryTime': '10-15 min delivery',
      },
      {
        'image': 'assets/images/cuisine/seekh_kabab/Chicken_Seekh_Kebab.jpeg',
        'description': 'Chicken Seekh Kabab',
        'price': 'Rs. 799',
        'deliveryTime': '10-15 min delivery',
      },
      {
        'image': 'assets/images/cuisine/seekh_kabab/Mutton_Seekh_Kebab.jpeg',
        'description': 'Mutton Seekh Kabab',
        'price': 'Rs. 999',
        'deliveryTime': '10-15 min delivery',
      },
      {
        'image': 'assets/images/cuisine/seekh_kabab/Shami_Seekh_Kebab.jpeg',
        'description': 'Shami Seekh Kabab',
        'price': 'Rs. 950',
        'deliveryTime': '10-15 min delivery',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Seekh Kabab')),
      body: SingleChildScrollView(
        child: Column(
          children: seekhKababItems.map((item) {
            return SeekhKababCardItem(
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

class SeekhKababCardItem extends StatefulWidget {
  final String imagePath;
  final String title;
  final String price;
  final String deliveryTime;
  final Function(String, String, String, bool) toggleFavorite;

  SeekhKababCardItem({
    required this.imagePath,
    required this.title,
    required this.price,
    required this.deliveryTime,
    required this.toggleFavorite,
  });

  @override
  _SeekhKababCardItemState createState() => _SeekhKababCardItemState();
}

class _SeekhKababCardItemState extends State<SeekhKababCardItem> {
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

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.title} added to cart!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 270,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SeekhKababDialog(
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

class SeekhKababDialog extends StatelessWidget {
  final String imagePath;
  final String title;
  final String price;

  SeekhKababDialog({
    required this.imagePath,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    String description = '';
    if (title == 'Beef Seekh Kabab') {
      description = 'Juicy and flavorful beef seekh kababs made with minced beef, spices, and herbs. Served with naan or rice for a complete meal.';
    } else if (title == 'Chicken Seekh Kabab') {
      description = 'Tender chicken seekh kababs seasoned with aromatic spices, grilled to perfection. A perfect combination with chutney or naan.';
    } else if (title == 'Mutton Seekh Kabab') {
      description = 'Rich and juicy mutton seekh kababs, marinated with traditional spices. Grilled to perfection for a smoky, mouthwatering flavor.';
    } else if (title == 'Shami Seekh Kabab') {
      description = 'Delicious Shami seekh kababs made with minced meat, spices, and lentils. Cooked to perfection and served hot for a satisfying meal.';
    }


    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset(imagePath)),
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
            Text(description, style: TextStyle(fontSize: 16, color: Colors.black)),
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

