import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:newfyp/home_page/bottom_navigation_bar/add_to_cart.dart';
import '../model/addtocart.dart';

class DbHelper {
  static Database? _db;

  // Singleton pattern to get the database instance
  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  // Initialize the database
  static Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'cart.db');
    return openDatabase(path, onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE cart(id INTEGER PRIMARY KEY AUTOINCREMENT, imagePath TEXT, title TEXT, price TEXT, quantity INTEGER)',
      );
    }, version: 1);
  }

  // Fetch all cart items
  static Future<List<CartItem>> getCartItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cart');

    return List.generate(maps.length, (i) {
      return CartItem(
        id: maps[i]['id'],
        imagePath: maps[i]['imagePath'],
        title: maps[i]['title'],
        price: maps[i]['price'],
        quantity: maps[i]['quantity'],
      );
    });
  }

  // Calculate the total price of all cart items
  static Future<double> getTotalPrice() async {
    final cartItems = await getCartItems(); // Fetch all cart items
    double totalPrice = 0;

    for (var item in cartItems) {
      double itemPrice = double.parse(item.price); // Ensure price is a double
      totalPrice += itemPrice * item.quantity;
    }

    return totalPrice;
  }

  // Add item to the cart
  static Future<void> addToCart(CartItem item) async {
    final existingItem = await getCartItemById(item.id!);
    if (existingItem != null) {
      existingItem.quantity += 1;
      await updateCartItem(existingItem);
    } else {
      // Add new item to cart
      await insertCartItem(item);
    }
  }

  // Fetch a cart item by ID
  static Future<CartItem?> getCartItemById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'cart',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return CartItem.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // Insert a cart item into the database
  static Future<void> insertCartItem(CartItem item) async {
    final db = await database;

    // Check if the item already exists in the cart
    final List<Map<String, dynamic>> existingItems = await db.query(
      'cart',
      where: 'id = ?',
      whereArgs: [item.id],
    );

    if (existingItems.isNotEmpty) {
      final existingItem = CartItem(
        id: existingItems.first['id'],
        imagePath: existingItems.first['imagePath'],
        title: existingItems.first['title'],
        price: existingItems.first['price'],
        quantity: existingItems.first['quantity'],
      );

      final updatedItem = CartItem(
        id: existingItem.id,
        imagePath: existingItem.imagePath,
        title: existingItem.title,
        price: existingItem.price,
        quantity: existingItem.quantity + item.quantity, // Add the quantity
      );

      await updateCartItem(updatedItem);
    } else {
      await db.insert(
        'cart',
        item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  // Update an existing cart item in the database
  static Future<void> updateCartItem(CartItem item) async {
    final db = await database;
    await db.update(
      'cart',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  // Delete a cart item from the database
  static Future<void> deleteCartItem(int id) async {
    final db = await database;
    await db.delete(
      'cart',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Clear all items from the cart
  static Future<void> clearCart() async {
    final db = await database;
    await db.delete('cart');
  }

  // Fetch a cart item by title
  static Future<CartItem?> getCartItemByTitle(String title) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
    await db.query('cart', where: 'title = ?', whereArgs: [title]);

    if (maps.isNotEmpty) {
      return CartItem(
        id: maps[0]['id'],
        imagePath: maps[0]['imagePath'],
        title: maps[0]['title'],
        price: maps[0]['price'],
        quantity: maps[0]['quantity'],
      );
    }
    return null;
  }
}
