import 'package:flutter/material.dart';

import '../database_helper/add_to_cart.dart';
import '../model/addtocart.dart';

class ExploreOffers extends StatelessWidget {
  const ExploreOffers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore Offers', style: TextStyle(fontWeight: FontWeight.w900,color: Colors.white),),
        centerTitle: true,
        backgroundColor: Color(0xff2C3E50),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Explore(),
            SizedBox(height: 20),
            Divider(thickness: 2,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Special Offers', style: TextStyle(fontSize: 27 , color: Colors.black,fontWeight: FontWeight.w900),),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('What are you waiting for?', style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w600),),
            ),
            SizedBox(height: 10,),
            ProductGrid(),
          ],
        ),
      ),
    );
  }
}


class Explore extends StatelessWidget {
  const Explore({super.key});

  void _showProductDialog(BuildContext context, String name, String price, String imagePath) {
    showDialog(
      context: context,
      barrierDismissible: true, // Allow tapping outside the dialog to close it
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            padding: EdgeInsets.all(16),
            height: 315, // Adjust the height of the dialog as needed
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog when clicked
                    },
                  ),
                ),
                Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  height: 100, // Adjust the image size
                ),
                SizedBox(height: 10),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff2C3E50),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Handle the order now action
                  },
                  child: Text(
                    'Order Now',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff2C3E50),
                    minimumSize: Size(150, 45), // Adjust the button size
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void addToCart() async {
    // Assuming quantity is 1 for now. You can modify it to increase based on user input.
    CartItem newItem = CartItem(
      imagePath: 'assets/images/shop_categories/cakes/pink_velvet.jpeg', // Update to actual image path
      title: 'Pink Velvet Cake', // Update to actual title
      price: 'Rs.1500', // Update to actual price
      quantity: 1, // Default quantity is 1
    );
    await DbHelper.insertCartItem(newItem);

    // Show a snack bar to notify the user
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Text('Pink Velvet Cake added to cart!'),
    // ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            _showProductDialog(
              context,
              'Pink Velvet Cake',
              'Rs.1500',
              'assets/images/shop_categories/cakes/pink_velvet.jpeg',
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 360,
              color: Colors.brown,
              child: Image.asset(
                'assets/images/shop_categories/cakes/pink_velvet.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Pink Velvet Cake',
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Text(
                'Rs.1500',
                style: TextStyle(
                  color: Color(0xff2C3E50),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Rs. 2000',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 19,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                height: 30,
                width: 90,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Center(
                    child: Text(
                      '15% off',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff2C3E50),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Center(
          child: SizedBox(
            height: 50,
            width: 190,
            child: ElevatedButton(
              onPressed: addToCart,
              child: const Text(
                'Add to Cart',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff2C3E50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

}




class ProductGrid extends StatelessWidget {
  final List<Map<String, String>> products = [
    {
      'image': 'assets/images/shop_categories/cakes/pink_velvet.jpeg',
      'name': 'Pink Velvet Cake',
      'price': 'Rs.1500',
      'previousPrice': 'Rs.2000',
    },
    {
      'image': 'assets/images/shop_categories/pizza/Margherita Pizza.jpeg',
      'name': 'Margherita Pizza',
      'price': 'Rs.1200',
      'previousPrice': 'Rs.1400',
    },
    {
      'image': 'assets/images/shop_categories/biryani/Sindhi Biryani.jpeg',
      'name': 'Sindhi Biryani',
      'price': 'Rs.1000',
      'previousPrice': 'Rs.1200',
    },
    {
      'image': 'assets/images/shop_categories/pasta/Chicken Tikka Pasta.jpeg',
      'name': 'Chicken Tikka Pasta',
      'price': 'Rs.900',
      'previousPrice': 'Rs.1100',
    },
    {
      'image': 'assets/images/shop_categories/cakes/Classic(One Bowl) Chocolate Cake.jpeg',
      'name': 'Chocolate Cake',
      'price': 'Rs.1500',
      'previousPrice': 'Rs.2000',
    },
    {
      'image': 'assets/images/shop_categories/pizza/Smoky BBQ Pizza.jpeg',
      'name': 'Smoky BBQ Pizza',
      'price': 'Rs.1200',
      'previousPrice': 'Rs.1400',
    },
    {
      'image': 'assets/images/shop_categories/biryani/Beef Biryani.jpeg',
      'name': 'Beef Biryani',
      'price': 'Rs.1000',
      'previousPrice': 'Rs.1200',
    },
    {
      'image': 'assets/images/shop_categories/pasta/Mac and Cheese.jpeg',
      'name': 'Mac and Cheese',
      'price': 'Rs.900',
      'previousPrice': 'Rs.1100',
    },
    {
      'image': 'assets/images/shop_categories/curry/chiken_Tikka_masala.jpeg',
      'name': 'Chicken Tikka Masala',
      'price': 'Rs.900',
      'previousPrice': 'Rs.1100',
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 11,
          mainAxisSpacing: 11,
          childAspectRatio: 0.7,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () => _showProductDialog(context, product),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        product['image']!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    product['name']!,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    product['price']!,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    product['previousPrice']!,
                    style: TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showProductDialog(BuildContext context, Map<String, String> product) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            clipBehavior: Clip.none, // This allows the close button to be placed outside the dialog
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        product['image']!,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      product['name']!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      product['price']!,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Add your order logic here
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: Text('Order Now', style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff2C3E50),
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -10,
                right: -10,
                child: IconButton(
                  icon: Icon(Icons.close, color: Colors.black),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

