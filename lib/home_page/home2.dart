import 'package:flutter/material.dart';
import 'package:newfyp/home_page/bottom_navigation_bar/user_Account.dart';
import 'package:newfyp/home_page/cuisine/chicken_tikka.dart';
import 'package:newfyp/home_page/cuisine/haleem.dart';
import 'package:newfyp/home_page/cuisine/paratha.dart';
import 'package:newfyp/home_page/cuisine/seekh_kabab.dart';
import 'package:newfyp/home_page/cuisine/vegetarian.dart';
import 'package:newfyp/home_page/explore_more/chicken_tikka_pizza.dart';
import 'package:newfyp/home_page/explore_more/fudgy_brownie.dart';
import 'package:newfyp/home_page/explore_more/mutton_pasta.dart';
import 'package:newfyp/home_page/explore_more/paneer_butter_masala.dart';
import 'package:newfyp/home_page/fast_delivery/classic_margherita_pizza.dart';
import 'package:newfyp/home_page/fast_delivery/homemade_beef_biryani.dart';
import 'package:newfyp/home_page/fast_delivery/karahi_gosht.dart';
import 'package:newfyp/home_page/fast_delivery/rich_chocolate_cake.dart';
import 'package:newfyp/home_page/fast_delivery/spicy_chicken_tikka_pasta.dart';
import 'package:newfyp/home_page/shop_categories/biryani/biryani.dart';
import 'package:newfyp/home_page/shop_categories/brownies/brownies.dart';
import 'package:newfyp/home_page/shop_categories/cake/cake.dart';
import 'package:newfyp/home_page/shop_categories/curry/curry.dart';
import 'package:newfyp/home_page/shop_categories/pasta/pasta.dart';
import 'package:newfyp/home_page/shop_categories/pizza/Margherita%20Pizza.dart';
import 'package:newfyp/drawer/side_bar.dart';
import 'package:newfyp/home_page/Explore_Offers.dart';

import 'explore_more/chocolate_cake.dart';

import 'package:flutter/material.dart';
import 'package:newfyp/drawer/side_bar.dart';
import 'package:newfyp/home_page/Explore_Offers.dart';
import 'explore_more/chocolate_cake.dart'; // Ensure you have the correct imports for your sections
import 'package:newfyp/home_page/shop_categories/pizza/Margherita%20Pizza.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Track the currently selected tab

  // List of widgets that correspond to each tab
  final List<Widget> _pages = [
    Scaffold(
      appBar: AppBar(
        title: Text('Home Chef Connect', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Color(0xff2C3E50),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      drawer: Side_Bar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Cuisine(),
            SizedBox(height: 10),
            SpecialOffersSection(),
            SizedBox(height: 10),
            ShopCategoriesSection(),
            FastDeliverySection(),
            SizedBox(height: 5),
            DealsAndDiscountsSection(),
            SizedBox(height: 5),
            ExploreMore(),
          ],
        ),
      ),
    ),
    Container(color: Colors.white),
    Container(color: Colors.white),
    User_Account(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Home Chef Connect', style: TextStyle(color: Colors.white)),
      //   centerTitle: true,
      //   backgroundColor: Color(0xff2C3E50),
      //   iconTheme: IconThemeData(
      //     color: Colors.white,
      //   ),
      // ),
      drawer: Side_Bar(),
      body: _pages[_selectedIndex], // Dynamically display the selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Update the selected index when the user taps a tab
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: 'Home',
            backgroundColor: Color(0xff2C3E50),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.white),
            label: 'Search',
            backgroundColor: Color(0xff2C3E50),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: Colors.white),
            label: 'Favorites',
            backgroundColor: Color(0xff2C3E50),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.white),
            label: 'Profile',
            backgroundColor: Color(0xff2C3E50),
          ),
        ],
      ),
    );
  }
}

// The rest of your widget definitions, like Cuisine, SpecialOffersSection, etc., remain the same


//Cuisine
class Cuisine extends StatelessWidget {
  const Cuisine({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Cuisine',
            style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w900),
          ),
        ),
        SizedBox(height: 5),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              GestureDetector(
                onTap : (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChickenTikkaCard()),);
    },
                  child: categoryContainer('assets/images/cuisine/Chicken_tikka/Achari_Chicken_Tikka.jpeg', 'Chicken Tikka')),

              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SeekhKabab()),);
                  },
                  child: categoryContainer('assets/images/cuisine/seekh_kabab/beef_seekh_kabab.jpeg', 'Seekh kabab')),

              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Haleem()),);
                },
                  child: categoryContainer('assets/images/cuisine/haleem/Beef_Haleem.jpeg', 'Haleem')),

              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Paratha()),);
                  },
                  child: categoryContainer('assets/images/cuisine/paratha/Keema_Paratha.jpeg', 'Paratha')),

              GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Vegetarian()),);
                  },
                  child: categoryContainer('assets/images/cuisine/vegetarian/Baingan_Bharta.jpeg', 'Vegetarian')),
            ],
          ),
        ),
      ],
    );
  }

  Widget categoryContainer(String imagePath, String label) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(imagePath),
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

// SpecialOffersSection
class SpecialOffersSection extends StatelessWidget {
  const SpecialOffersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 400,
            height: 200,
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'GET 15% OFF',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Text(
                  'Special Offers',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Get exclusive discounts on selected items! Limited time offer.',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ExploreOffers()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: Text(
                    'Explore Offers',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),

          Container(
            width: 400,
            height: 200,
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            padding: const EdgeInsets.all(16.0),
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
            child: Row(
              children: [
                Container(
                  width: 200,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage('assets/images/shop_categories/cakes/Classic(One Bowl) Chocolate Cake.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 12),

                // Texts and button on the right side
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Classic(One Bowl) Chocolate Cake',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Delicious homemade chocolate cake',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate or add functionality here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                          minimumSize: Size(80, 40),
                        ),
                        child: Text(
                          'Order Now',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//ShopCategoriesSection
class ShopCategoriesSection extends StatelessWidget {
  const ShopCategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Shop Categories', style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w900)),
          ),
        ),
        SizedBox(height: 1),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PizzaCard()),
                  );
                },
                child: shopCategoryCircleAvatar('assets/images/shop_categories/pizza/Smoky BBQ Pizza.jpeg', 'Pizza'),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BiryaniCard()),
                  );
                },
                child: shopCategoryCircleAvatar('assets/images/shop_categories/biryani/karachi_biryani.jpeg', 'Biryani'),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CurryCard()),
                  );
                },
                child: shopCategoryCircleAvatar('assets/images/shop_categories/curry/karahi_Gosht.jpeg', 'Curry'),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PastaCard()),
                  );
                },
                child: shopCategoryCircleAvatar('assets/images/shop_categories/pasta/Spaghetti Bolognese.jpeg', 'Pasta'),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BrowniesCard()),
                  );
                },
                child: shopCategoryCircleAvatar('assets/images/shop_categories/brownies/Fudgy Brownies.jpeg', 'Brownies'),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CakeCard()),
                  );
                },
                child: shopCategoryCircleAvatar('assets/images/shop_categories/cakes/Cherry_chocolate.jpeg', 'Cake'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget shopCategoryCircleAvatar(String imagePath, String label) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 80,
            backgroundImage: AssetImage(imagePath),
          ),
          SizedBox(height: 8.0),
          Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}


class FastDeliverySection extends StatelessWidget {
  const FastDeliverySection({super.key});

  final List<Map<String, String>> fastDeliveryItems = const [
    {
      'image': 'assets/images/shop_categories/biryani/Sindhi Biryani.jpeg',
      'description': 'Homemade Beef Biryani',
      'price': '\$12.99',
      'deliveryTime': '10-15 min delivery',
    },
    {
      'image': 'assets/images/shop_categories/pizza/Margherita Pizza.jpeg',
      'description': 'Classic Margherita Pizza',
      'price': '\$9.99',
      'deliveryTime': '10-15 min delivery',
    },
    {
      'image': 'assets/images/shop_categories/cakes/Chocolate Truffle Cake.jpeg',
      'description': 'Rich Chocolate Cake',
      'price': '\$7.99',
      'deliveryTime': '10-15 min delivery',
    },
    {
      'image': 'assets/images/shop_categories/pasta/Chicken Tikka Pasta.jpeg',
      'description': 'Spicy Chicken Tikka Pasta',
      'price': '\$8.99',
      'deliveryTime': '10-15 min delivery',
    },
    {
      'image': 'assets/images/shop_categories/curry/karahi_Gosht.jpeg',
      'description': 'Karahi Gosht',
      'price': '\$10.99',
      'deliveryTime': '10-15 min delivery',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Fast Delivery', style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w900)),
          ),
        ),
        SizedBox(height: 1),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: fastDeliveryItems.map((item) {
              return GestureDetector(
                onTap: () {
                  if (item['description'] == 'Homemade Beef Biryani') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomemadeBeefBiryani()),
                    );
                  } else if (item['description'] == 'Classic Margherita Pizza') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ClassicMargheritaPizza()),
                    );
                  } else if (item['description'] == 'Rich Chocolate Cake') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RichChocolateCake()),
                    );
                  } else if (item['description'] == 'Spicy Chicken Tikka Pasta') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SpicyChickenTikkaPasta()),
                    );
                  } else if (item['description'] == 'Karahi Gosht') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => KarahiGosht()),
                    );
                  }
                },
                child: fastDeliveryContainer(item),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget fastDeliveryContainer(Map<String, String> item) {
    return Container(
      width: 370,
      height: 270,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
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
          Stack(
            children: [
              // Image with rounded corners
              Container(
                width: double.infinity,
                height: 170,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  image: DecorationImage(
                    image: AssetImage(item['image']!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Favorite icon in the top-right corner
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () {
                    // Handle favorite toggle here
                  },
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              // Button in the top-left corner
              Positioned(
                top: 8,
                left: 8,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle button action here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff2C3E50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.card_giftcard, color: Colors.white, size: 17),
                      SizedBox(width: 8),
                      Text(
                        'Gift: Free delivery',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['description']!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5),
                Text(
                  item['price']!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  item['deliveryTime']!,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//DealsAndDiscountsSection
class DealsAndDiscountsSection extends StatelessWidget {
  const DealsAndDiscountsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Deals & Discounts',
            style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w900),
          ),
        ),
        SizedBox(height: 2),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              dealContainer('assets/images/shop_categories/curry/paneer_butter_masala.jpeg'),
              dealContainer('assets/images/shop_categories/curry/butter_chicken.jpeg'),
              dealContainer('assets/images/shop_categories/curry/chiken_Tikka_masala.jpeg'),
              dealContainer('assets/images/shop_categories/curry/mutton_karahi.jpeg'),
              dealContainer('assets/images/shop_categories/curry/karahi_Gosht.jpeg'),
            ],
          ),
        ),
      ],
    );
  }

  Widget dealContainer(String imagePath) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () {
                  // Handle favorite toggle here
                },
                child: Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

//ExploreMore

class ExploreMore extends StatelessWidget {
  const ExploreMore({super.key});

  final List<Map<String, String>> exploremoreItems = const [
    {
      'image': 'assets/images/shop_categories/pizza/chicken_tikka_pizza.jpeg',
      'description': 'Chicken Tikka Pizza',
      'price': '\$12.99',
      'deliveryTime': '10-15 min delivery',
      'page': 'ChickenTikkaPizza',
    },
    {
      'image': 'assets/images/shop_categories/cakes/Classic(One Bowl) Chocolate Cake.jpeg',
      'description': 'Classic(One Bowl) Chocolate Cake',
      'price': '\$9.99',
      'deliveryTime': '10-15 min delivery',
      'page': 'ChocolateCake',
    },
    {
      'image': 'assets/images/shop_categories/pasta/Mutton Pasta.jpeg',
      'description': 'Mutton Pasta',
      'price': '\$11.99',
      'deliveryTime': '10-15 min delivery',
      'page': 'MuttonPasta',
    },
    {
      'image': 'assets/images/shop_categories/brownies/Fudgy Brownies.jpeg',
      'description': 'Fudgy Brownie',
      'price': '\$7.99',
      'deliveryTime': '10-15 min delivery',
      'page': 'FudgyBrownie',
    },
    {
      'image': 'assets/images/shop_categories/curry/paneer_butter_masala.jpeg',
      'description': 'Paneer butter masala',
      'price': '\$11.99',
      'deliveryTime': '10-15 min delivery',
      'page': 'PaneerButterMasala',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Explore More',
              style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w900),
            ),
          ),
        ),
        SizedBox(height: 1),
        SingleChildScrollView(
          child: Column(
            children: exploremoreItems.map((item) => exploremoreContainer(context, item)).toList(),
          ),
        ),
      ],
    );
  }

  Widget exploremoreContainer(BuildContext context, Map<String, String> item) {
    return GestureDetector(
      onTap: () {
        // Navigate to the respective page based on the 'page' key in the item map
        String page = item['page'] ?? '';

        if (page == 'ChickenTikkaPizza') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChickenTikkaPizza()),
          );
        } else if (page == 'ChocolateCake') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChocolateCake()),
          );
        } else if (page == 'MuttonPasta') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MuttonPasta()),
          );
        } else if (page == 'FudgyBrownie') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FudgyBrownie()),
          );
        } else if (page == 'PaneerButterMasala') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PaneerButterMasala()),
          );
        } else {
          // Handle case if no page is found
          print("No page found for $page");
        }
      },
      child: Container(
        width: 470,
        height: 270,
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
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
            Stack(
              children: [
                // Image with rounded corners
                Container(
                  width: double.infinity,
                  height: 170,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                    image: DecorationImage(
                      image: AssetImage(item['image']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Favorite icon in the top-right corner
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      // Handle favorite toggle here
                    },
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                // Button in the top-left corner
                Positioned(
                  top: 8,
                  left: 8,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle button action here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff2C3E50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.card_giftcard, color: Colors.white, size: 17),
                        SizedBox(width: 8),
                        Text(
                          'Gift: Free delivery',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['description']!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Text(
                    item['price']!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    item['deliveryTime']!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.green[700],
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



