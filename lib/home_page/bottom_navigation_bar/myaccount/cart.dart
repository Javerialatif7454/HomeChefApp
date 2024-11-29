import 'package:flutter/material.dart';
import 'package:newfyp/home_page/home2.dart';
import '../../../database_helper/add_to_cart.dart';
import '../../../database_helper/orderitemdb.dart';
import '../../../model/addtocart.dart';
import '../../../model/orderitems.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartItem> cartItems = [];
  final double exchangeRate = 80.0;

  @override
  void initState() {
    super.initState();
    loadCartItems();
  }

  Future<void> loadCartItems() async {
    final items = await DbHelper.getCartItems();
    setState(() {
      cartItems = items;
    });
  }

  double getTotalPrice() {
    double total = 0;
    for (var item in cartItems) {
      String cleanedPrice = item.price.replaceAll(RegExp(r'[^0-9.]'), '');

      print('Item: ${item.title}, Cleaned Price: $cleanedPrice, Quantity: ${item.quantity}');

      double price = double.tryParse(cleanedPrice) ?? 0.0;

      double itemTotal = price * item.quantity;
      print('Item Total: $itemTotal');

      total += itemTotal;
    }
    print('Total Price in USD: $total');

    return total * exchangeRate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
      ),
      body: cartItems.isEmpty
          ? Center(child: Text('No items in the cart'))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  leading: Image.asset(item.imagePath, width: 50, height: 50),
                  title: Text(item.title),
                  subtitle: Text(item.price),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.green),
                    onPressed: () {
                      _showDeleteDialog(item);
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: Rs. ${getTotalPrice().toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    placeOrder();
                  },
                  child: Text('Place Order'),
                  style: ElevatedButton.styleFrom(
                    elevation: 5.0,
                    iconColor: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(CartItem item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                item.imagePath,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 8),
              Text.rich(
                TextSpan(
                  text: 'Are you sure you want to delete ', // Regular text
                  style: TextStyle(fontSize: 16),
                  children: [
                    TextSpan(
                      text: '"${item.title}"',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: ' from your cart?',
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _deleteItem(item);
                Navigator.pop(context);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteItem(CartItem item) async {
    await DbHelper.deleteCartItem(item.id!);

    loadCartItems();
  }

  void placeOrder() async {
    await saveOrderDetails();

    await DbHelper.clearCart();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Order Placed'),
          content: Text('Your order has been successfully placed.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> saveOrderDetails() async {
    double totalPrice = getTotalPrice();
    String orderSummary = cartItems.map((item) => "${item.title} x${item.quantity}").join(", ");

    await dbHelper.saveOrder(Order(
      items: orderSummary,
      totalPrice: totalPrice,
      date: DateTime.now().toString(),
    ));
  }
}

