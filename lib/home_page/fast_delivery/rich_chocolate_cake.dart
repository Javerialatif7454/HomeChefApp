import 'package:flutter/material.dart';

class RichChocolateCake extends StatelessWidget {
  const RichChocolateCake({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Food Store',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // First container with image
              Container(
                width: 350, // Set the width of the container
                height: 450, // Set the height of the container
                decoration: BoxDecoration(
                  color: Colors.white, // Set background color to white
                  borderRadius: BorderRadius.circular(10), // Optional: rounded corners
                ),
                child: Center(
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/shop_categories/cakes/Chocolate Truffle Cake.jpeg', // Your image path
                      width: 300, // Set the width of the image (can adjust as needed)
                      height: 270, // Set the height of the image (must be the same as width for perfect circle)
                      fit: BoxFit.cover, // Ensures the image covers the circular area without distortion
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16), // Spacing between image and description container
          
              // Description container
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Description heading
                    Text(
                      'Description', // Heading for the description
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8), // Spacing between heading and text
                    // Description text
                    Text(
                      'This Chocolate Truffle Cake is crafted with layers of rich chocolate sponge and smooth ganache, delivering a luxurious, melt-in-your-mouth experience.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[800],
                      ),
                      textAlign: TextAlign.justify, // Text alignment for better readability
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16), // Spacing between description and "Add to Cart" container
          
              // Second container with text and add to cart button
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Chocolate Truffle Cake', // Product name
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8), // Spacing between name and price
                    Text(
                      '\$18.99', // Product price (Updated for Rich Chocolate Cake)
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.green[700],
                      ),
                    ),
                    SizedBox(height: 16), // Spacing between price and button
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          // Add to cart logic here
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          backgroundColor: Color(0xff2C3E50),
                          // Button color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Add to Cart',
                          style: TextStyle(color: Colors.white),
                        ),
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
