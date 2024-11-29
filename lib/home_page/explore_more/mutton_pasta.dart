import 'package:flutter/material.dart';
import '../../database_helper/add_to_cart.dart';
import '../../database_helper/cheken_tika.dart';
import '../../model/addtocart.dart';

class MuttonPasta extends StatefulWidget {
  const MuttonPasta({super.key});

  @override
  State<MuttonPasta> createState() => _MuttonPastaState();
}

class _MuttonPastaState extends State<MuttonPasta> {
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

  void toggleFavorite(
      String imagePath, String title, String price, bool isFavorite) async {
    if (isFavorite) {
      await DBHelper.insertItem(imagePath, title, price);
      setState(() {
        favoriteItems.add({'imagePath': imagePath, 'title': title, 'price': price});
      });
    } else {
      await DBHelper.deleteItem(imagePath);
      setState(() {
        favoriteItems.removeWhere((item) => item['imagePath'] == imagePath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mutton Pasta")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dealContainer(
              context,
              'assets/images/shop_categories/pasta/Mutton Pasta.jpeg',
              'Mutton Pasta',
              'Rs. 1299',
              'A flavorful and spicy pasta with mutton chunks and rich sauces.',
            ),
            dealContainer(
              context,
              'assets/images/shop_categories/pasta/Chicken Tikka Pasta.jpeg',
              'Chicken Tikka Pasta',
              'Rs. 1199',
              'A delicious pasta with grilled chicken tikka, onions, and spices.',
            ),
            dealContainer(
              context,
              'assets/images/shop_categories/pasta/Mac and Cheese.jpeg',
              'Mac and Cheese Pasta',
              'Rs. 999',
              'A creamy and cheesy pasta with a delicious blend of flavors.',
            ),
            dealContainer(
              context,
              'assets/images/shop_categories/pasta/Spaghetti Bolognese.jpeg',
              'Spaghetti Pasta',
              'Rs. 1399',
              'A classic spaghetti pasta with a savory bolognese sauce.',
            ),
          ],
        ),
      ),
    );
  }

  Widget dealContainer(
      BuildContext context, String imagePath, String productName, String price, String description) {
    void addToCart() async {
      CartItem newItem = CartItem(
        imagePath: imagePath,
        title: productName,
        price: price,
        quantity: 1,
      );
      await DbHelper.insertCartItem(newItem);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$productName added to cart!')),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(
                productName: productName,
                price: price,
                imagePath: imagePath,
                description: description,
              ),
            ),
          );
        },
        child: Container(
          height: 135,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imagePath,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            productName,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              const Icon(Icons.timer,
                                  color: Colors.green, size: 16),
                              const SizedBox(width: 5),
                              Text(
                                '10-15 mins',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.green[700]),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            price,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const SizedBox(height: 7),
                          Center(
                            child: SizedBox(
                              width: 140,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: addToCart,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff2C3E50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'Add to Cart',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        icon: Icon(
                          favoriteItems.any((item) => item['imagePath'] == imagePath)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: favoriteItems.any((item) => item['imagePath'] == imagePath)
                              ? Colors.green
                              : Colors.black,
                        ),
                        onPressed: () {
                          final isFavorite = favoriteItems
                              .any((item) => item['imagePath'] == imagePath);
                          toggleFavorite(imagePath, productName, price, !isFavorite);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ProductDetailScreen extends StatelessWidget {
  final String productName;
  final String price;
  final String imagePath;
  final String description;

  const ProductDetailScreen({
    required this.productName,
    required this.price,
    required this.imagePath,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productName),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipOval(
                child: Image.asset(
                  imagePath,
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              productName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              price,
              style: TextStyle(fontSize: 20, color: Colors.green[700]),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor: const Color(0xff2C3E50),
                ),
                child: const Text(
                  'Order Now',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
