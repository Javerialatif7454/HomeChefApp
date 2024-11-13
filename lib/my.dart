// import 'package:flutter/material.dart';
// import 'package:newfyp/cuisines/biryani/biryani.dart';
// import 'package:newfyp/cuisines/brownies/brownies.dart';
// import 'package:newfyp/cuisines/cake/cake.dart';
// import 'package:newfyp/cuisines/curry/curry.dart';
// import 'package:newfyp/cuisines/pasta/pasta.dart';
// import 'package:newfyp/cuisines/pizza/Margherita%20Pizza.dart';
// import 'package:newfyp/drawer/side_bar.dart';
// import 'package:newfyp/home_page/Explore_Offers.dart';
// import 'package:newfyp/home_page/user_Account.dart';
//
// class home_page extends StatefulWidget {
//   const home_page({super.key});
//
//   @override
//   State<home_page> createState() => _home_pageState();
// }
//
// class _home_pageState extends State<home_page> {
//   int myIndex = 0;
//
//   List<Widget> widgetList = [
//     SingleChildScrollView(
//       child: Column(
//         children: const [
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             child: CuisinesSection(),
//           ),
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             child: DealsSection(),
//           ),
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             child: ShopCategoriesSection(),
//           ),
//         ],
//       ),
//     ),
//
//     Center(child: Text('Search Page', style: TextStyle(fontSize: 40))),
//     User_Account(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Allama Iqbal Town, Lahore'),
//         centerTitle: true,
//         backgroundColor: Colors.blueGrey,
//       ),
//       drawer: Side_Bar(),
//       body: widgetList[myIndex],
//     );
//   }
// }
//
// // Cuisines Section
// class CuisinesSection extends StatelessWidget {
//   const CuisinesSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "Cuisines",
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 10),
//         SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => PizzaCard()),
//                     );
//                   },
//                   child: cuisineCircleAvatar('assets/images/pizza/Smoky BBQ Pizza.jpeg', 'Pizza'),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => BiryaniCard()),
//                     );
//                   },
//                   child: cuisineCircleAvatar('assets/images/biryani/karachi_biryani.jpeg', 'Biryani'),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => CurryCard()),
//                     );
//                   },
//                   child: cuisineCircleAvatar('assets/images/curry/karahi_Gosht.jpeg', 'Curry'),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => PastaCard()),
//                     );
//                   },
//                   child: cuisineCircleAvatar('assets/images/pasta/Spaghetti Bolognese.jpeg', 'Pasta'),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => BrowniesCard()),
//                     );
//                   },
//                   child: cuisineCircleAvatar('assets/images/brownies/Fudgy Brownies.jpeg', 'Brownies'),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => CakeCard()),
//                     );
//                   },
//                   child: cuisineCircleAvatar('assets/images/cakes/Cherry_chocolate.jpeg', 'Cake'),
//                 ),
//               ],
//             )
//
//         ),
//       ],
//     );
//   }
//
//   Widget cuisineCircleAvatar(String imagePath, String label) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         children: [
//           CircleAvatar(
//             radius: 80,
//             backgroundImage: AssetImage(imagePath),
//           ),
//           SizedBox(height: 8.0),
//           Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
//         ],
//       ),
//     );
//   }
// }
//
// // Deals Section
// class DealsSection extends StatelessWidget {
//   const DealsSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           width: double.infinity,
//           height: 190,
//           padding: const EdgeInsets.all(16.0),
//           margin: const EdgeInsets.symmetric(horizontal: 8.0),
//           decoration: BoxDecoration(
//             color: Colors.black,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(child: Text('GET 15% OFF', style: TextStyle(color: Colors.white),)),
//               Text(
//                 'Special Offers',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//               SizedBox(height: 25),
//               Text(
//                 'Get exclusive discounts on selected items! Limited time offer.',
//                 style: TextStyle(fontSize: 14, color: Colors.white),
//               ),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => ExploreOffers()),);
//                 },
//                 child: Text('Explore Offers', style: TextStyle(color: Colors.white),),
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.red
//
//                 ),),
//             ],
//           ),
//         ),
//         SizedBox(height: 20),
//         Text(
//           'Deals & Discounts',
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 10),
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: [
//               dealContainer('assets/images/curry/paneer_butter_masala.jpeg'),
//               dealContainer('assets/images/curry/butter_chicken.jpeg'),
//               dealContainer('assets/images/curry/chiken_Tikka_masala.jpeg'),
//               dealContainer('assets/images/curry/mutton_karahi.jpeg'),
//               dealContainer('assets/images/curry/karahi_Gosht.jpeg'),
//             ],
//           ),
//         ),
//         // Space between Deals and new Container
//
//
//       ],
//     );
//   }
//
//   Widget dealContainer(String imagePath) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         width: 150,
//         height: 150,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           image: DecorationImage(
//             image: AssetImage(imagePath),
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
// // Shop Categories Section
// class ShopCategoriesSection extends StatelessWidget {
//   const ShopCategoriesSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Shop Categories',
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 7),
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: [
//               shopCategoryItem('assets/images/cakes/Classic(One Bowl) Chocolate Cake.jpeg', 'Cakes'),
//               shopCategoryItem('assets/images/pizza/Fajita Pizza.jpeg', 'Pizza'),
//               shopCategoryItem('assets/images/curry/karahi_Gosht.jpeg', 'Food'),
//             ],
//           ),
//         ),
//         SizedBox(height: 20),
//
//         Text(
//           'Home Chef',
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 10),
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   fastDeliveryItem('assets/images/cakes/Cherry_chocolate.jpeg', 'Cake'),
//                   fastDeliveryItem('assets/images/pizza/Smoky BBQ Pizza.jpeg', 'Pizza'),
//                   fastDeliveryItem('assets/images/brownies/Fudgy Brownies.jpeg', 'Brwonie'),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget shopCategoryItem(String imagePath, String label) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         children: [
//           GestureDetector(
//             onTap: () {
//               // Add navigation functionality here
//             },
//             child: Container(
//               width: 200,
//               height: 200,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 image: DecorationImage(
//                   image: AssetImage(imagePath),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 5),
//           Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
//         ],
//       ),
//     );
//   }
//
//   Widget fastDeliveryItem(String imagePath, String label) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         children: [
//           GestureDetector(
//             onTap: () {
//               // Add navigation functionality here for fast delivery items
//             },
//             child: Container(
//               width: 150,
//               height: 150,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 image: DecorationImage(
//                   image: AssetImage(imagePath),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 5),
//           Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
//         ],
//       ),
//     );
//   }
// }
//
