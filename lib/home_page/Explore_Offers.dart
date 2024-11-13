import 'package:flutter/material.dart';

class ExploreOffers extends StatelessWidget {
  const ExploreOffers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore Offers', style: TextStyle(fontWeight: FontWeight.w900),),
        centerTitle: true,
        backgroundColor: Colors.pink,
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Pink Velvet Cake',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                'Rs.1500',
                style: TextStyle(color: Colors.pink, fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(width: 5),
              Text(
                'Rs. 2000',
                style: TextStyle(color: Colors.grey, fontSize: 19, fontWeight: FontWeight.w400),
              ),
              SizedBox(width: 5),
              SizedBox(
                height: 30,
                width: 90,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Center(
                    child: Text(
                      '15% off',
                      style: TextStyle(color: Colors.pink, fontWeight: FontWeight.w700, fontSize: 12),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink.shade100,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 6),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                width: 270,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 11),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: IconButton(
                  onPressed: () {
                    // Add to favorites functionality here
                  },
                  icon: Icon(Icons.favorite),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
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
          return Container(
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
          );
        },
      ),
    );
  }
}

