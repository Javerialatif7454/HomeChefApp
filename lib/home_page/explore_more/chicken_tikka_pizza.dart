import 'package:flutter/material.dart';
import '../../database_helper/add_to_cart.dart';
import '../../database_helper/cheken_tika.dart';
import '../../model/addtocart.dart';
import 'chocolate_cake.dart';

class ChickenTikkaPizza extends StatefulWidget {
  const ChickenTikkaPizza({super.key});

  @override
  State<ChickenTikkaPizza> createState() => _ChickenTikkaPizzaState();
}

class _ChickenTikkaPizzaState extends State<ChickenTikkaPizza> {
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
      appBar: AppBar(title: const Text("Chicken Tikka Pizza")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dealContainer(
              context,
              'assets/images/shop_categories/pizza/chicken_tikka_pizza.jpeg',
              'Chicken Tikka Pizza',
              'Rs. 999',
              'A spicy and flavorful pizza topped with chicken tikka, onions, and cheese.',
            ),
            dealContainer(
              context,
              'assets/images/shop_categories/curry/butter_chicken.jpeg',
              'Butter Chicken',
              'Rs. 1399',
              'A creamy and rich curry with tender chicken pieces.',
            ),
            dealContainer(
              context,
              'assets/images/shop_categories/curry/chiken_Tikka_masala.jpeg',
              'Chicken Tikka Masala',
              'Rs. 1299',
              'A savory and tangy masala curry with grilled chicken tikka.',
            ),
            dealContainer(
              context,
              'assets/images/shop_categories/curry/mutton_karahi.jpeg',
              'Mutton Karahi',
              'Rs. 1999',
              'A flavorful curry made with tender mutton pieces cooked in a spicy gravy.',
            ),
            dealContainer(
              context,
              'assets/images/shop_categories/curry/karahi_Gosht.jpeg',
              'Karahi Gosht',
              'Rs. 1799',
              'A traditional Pakistani dish made with spicy mutton or chicken.',
            ),
          ],
        ),
      ),
    );
  }

  Widget dealContainer(
      BuildContext context,
      String imagePath,
      String productName,
      String price,
      String description,
      ) {
    void addToCart() async {
      CartItem newItem = CartItem(
        imagePath: imagePath,
        title: productName,
        price: price,
        quantity: 1,
      );
      await DbHelper.insertCartItem(newItem);

      // Notify the user
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
                              const Icon(Icons.timer, color: Colors.green, size: 16),
                              const SizedBox(width: 5),
                              Text(
                                '10-15 mins',
                                style: TextStyle(fontSize: 12, color: Colors.green[700]),
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
                              ? Colors.green // Use a predefined green color
                              : Colors.black,
                        ),
                        onPressed: () {
                          final isFavorite =
                          favoriteItems.any((item) => item['imagePath'] == imagePath);
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
