import 'package:flutter/material.dart';
import '../../../database_helper/add_to_cart.dart';
import '../../../model/addtocart.dart';

class ProductPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String price;

  ProductPage({
    required this.imagePath,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(imagePath, height: 250),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text('Price: Rs. $price', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Add the item to the cart
                CartItem newItem = CartItem(
                  imagePath: imagePath,
                  title: title,
                  price: price,
                  quantity: 1, // Default quantity is 1
                );
                await DbHelper.addToCart(newItem);

                // Optionally, show a message to the user
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$title has been added to the cart')),
                );
              },
              child: Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
