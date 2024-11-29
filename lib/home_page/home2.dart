import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:newfyp/home_page/bottom_navigation_bar/myaccount/cart.dart';
import 'package:newfyp/home_page/bottom_navigation_bar/myaccount/user_Account.dart';
import 'package:sqflite/sqflite.dart';
import 'package:newfyp/database_helper/database_helper.dart';
import 'package:newfyp/home_page/explore_more/chocolate_cake.dart' as chocolate;
import 'package:newfyp/home_page/explore_more/mutton_pasta.dart' as pasta;
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
import '../database_helper/cheken_tika.dart';
import '../drawer/favorites.dart';
import 'explore_more/chocolate_cake.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // List of widgets that correspond to each tab
  final List<Widget> _pages = [
    // Home page
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DiscountContainer(),
              SizedBox(height: 10),
              Cuisine(),
              SizedBox(height: 10),
              SpecialOffersSection(),
              SizedBox(height: 10),
              ShopCategoriesSection(),
              FastDeliverySection(),
              SizedBox(height: 10,),
              ExploreMore(),
            ],
          ),
        ),
      ),
    ),
    FavoritesPage(),
    CartPage(),
    UserAccountPage(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Side_Bar(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: 'Home',
            backgroundColor: Color(0xff2C3E50),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: Colors.white),
            label: 'Favorites',
            backgroundColor: Color(0xff2C3E50),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            label: 'Cart',
            backgroundColor: Color(0xff2C3E50),

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.white),
            label: 'Account',
            backgroundColor: Color(0xff2C3E50),
          ),
        ],
      ),
    );
  }
}


//Discount Container
class DiscountContainer extends StatelessWidget {
  const DiscountContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        color: Color(0xff2C3E50),
      ),
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Column containing the text
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 25), // Adjust this value to control the position of the text
              Text(
                'Get 40% discount on',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2),
              Text(
                'your first order',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2),
              Text(
                'from app',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Image.asset(
            'assets/images/new/aesthetic.jpeg',
            width: 115,
            height: 115,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}

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


//Fast Delivery Section
class FastDeliverySection extends StatefulWidget {
  const FastDeliverySection({super.key});

  @override
  _FastDeliverySectionState createState() => _FastDeliverySectionState();
}

class _FastDeliverySectionState extends State<FastDeliverySection> {
  final List<Map<String, String>> fastDeliveryItems = [
    {
      'image': 'assets/images/shop_categories/biryani/Sindhi Biryani.jpeg',
      'description': 'Homemade Beef Biryani',
      'price': 'Rs. 1299',
      'deliveryTime': '10-15 min delivery',
    },
    {
      'image': 'assets/images/shop_categories/pizza/Margherita Pizza.jpeg',
      'description': 'Classic Margherita Pizza',
      'price': 'Rs. 1200',
      'deliveryTime': '10-15 min delivery',
    },
    {
      'image': 'assets/images/shop_categories/curry/karahi_Gosht.jpeg',
      'description': 'Karahi Gosht',
      'price': 'Rs. 999',
      'deliveryTime': '10-15 min delivery',
    },
    {
      'image': 'assets/images/shop_categories/cakes/Chocolate Truffle Cake.jpeg',
      'description': 'Chocolate Truffle Cake',
      'price': 'Rs. 899',
      'deliveryTime': '10-15 min delivery',
    },
    {
      'image': 'assets/images/shop_categories/pasta/Chicken Tikka Pasta.jpeg',
      'description': 'Chicken Tikka Pasta',
      'price': 'Rs. 799',
      'deliveryTime': '10-15 min delivery',
    },
  ];

  List<Map<String, String>> favoriteItems = [];

  @override
  void initState() {
    super.initState();
    loadFavoriteItems();
  }

  Future<void> loadFavoriteItems() async {
    final items = await DBHelper.getItems(); // Load favorite items from DB
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
      await DBHelper.insertItem(imagePath, title, price); // Save to database
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Fast Delivery',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        SizedBox(height: 1),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: fastDeliveryItems.map((item) {
              bool isFavorite = favoriteItems
                  .any((favItem) => favItem['imagePath'] == item['image']);

              return GestureDetector(
                onTap: () {
                  // Handle navigation for each item (customize as needed)
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
                  } else if (item['description'] == 'Karahi Gosht') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => KarahiGosht()),
                    );
                  } else if (item['description'] == 'Chocolate Truffle Cake') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RichChocolateCake()),
                    );
                  } else if (item['description'] == 'Chicken Tikka Pasta') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SpicyChickenTikkaPasta()),
                    );
                  }
                },
                child: fastDeliveryContainer(item, isFavorite),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget fastDeliveryContainer(Map<String, String> item, bool isFavorite) {
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
                    image: AssetImage(item['image'] ?? ''),
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
                    setState(() {
                      isFavorite = !isFavorite;
                      toggleFavorite(
                        item['image'] ?? '',
                        item['description'] ?? '',
                        item['price'] ?? '',
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
              // Button in the top-left corner (optional)
              Positioned(
                top: 8,
                left: 8,
                child: ElevatedButton(
                  onPressed: () {},
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
                  item['description'] ?? '',
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
                  item['price'] ?? '',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  item['deliveryTime'] ?? '',
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




//ExploreMore
class ExploreMore extends StatelessWidget {
  const ExploreMore({super.key});

  final List<Map<String, String>> exploremoreItems = const [
    {
      'image': 'assets/images/shop_categories/pizza/chicken_tikka_pizza.jpeg',
      'description': 'Chicken Tikka Pizza',
      'price': 'Rs. 999',
      'deliveryTime': '10-15 min delivery',
      'page': 'ChickenTikkaPizza',
    },
    {
      'image': 'assets/images/shop_categories/cakes/Classic(One Bowl) Chocolate Cake.jpeg',
      'description': 'Classic(One Bowl) Chocolate Cake',
      'price': 'Rs. 1299',
      'deliveryTime': '10-15 min delivery',
      'page': 'ChocolateCake',
    },
    {
      'image': 'assets/images/shop_categories/pasta/Mutton Pasta.jpeg',
      'description': 'Mutton Pasta',
      'price': 'Rs. 1299',
      'deliveryTime': '10-15 min delivery',
      'page': 'MuttonPasta',
    },
    {
      'image': 'assets/images/shop_categories/brownies/Fudgy Brownies.jpeg',
      'description': 'Fudgy Brownie',
      'price': 'Rs. 799',
      'deliveryTime': '10-15 min delivery',
      'page': 'FudgyBrownie',
    },
    {
      'image': 'assets/images/shop_categories/curry/paneer_butter_masala.jpeg',
      'description': 'Paneer Butter Masala',
      'price': 'Rs. 1299',
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
        String page = item['page'] ?? '';

        if (page == 'ChickenTikkaPizza') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChickenTikkaPizza()),
          );
        } else if (page == 'ChocolateCake') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => chocolate.ChocolateCake()),
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



