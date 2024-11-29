import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

import '../model/addtocart.dart';
import '../model/orderitems.dart';

class dbHelper {
  static Database? _database;

  // Open the database
  static Future<Database> getDatabase() async {
    if (_database != null) return _database!;

    _database = await openDatabase(
      join(await getDatabasesPath(), 'cart_orders.db'),
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE cart(
            id INTEGER PRIMARY KEY,
            title TEXT,
            price TEXT,
            imagePath TEXT,
            quantity INTEGER
          )
        ''');
        db.execute('''
          CREATE TABLE orders(
            id INTEGER PRIMARY KEY,
            items TEXT,
            totalPrice REAL,
            date TEXT
          )
        ''');
      },
      version: 1,
    );
    return _database!;
  }

  static Future<void> addToCart(CartItem item) async {
    final db = await getDatabase();
    await db.insert(
      'cart',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<CartItem>> getCartItems() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('cart');

    return List.generate(maps.length, (i) {
      return CartItem(
        id: maps[i]['id'],
        title: maps[i]['title'],
        price: maps[i]['price'],
        imagePath: maps[i]['imagePath'],
        quantity: maps[i]['quantity'],
      );
    });
  }

  static Future<void> updateCartItemQuantity(int id, int quantity) async {
    final db = await getDatabase();
    await db.update(
      'cart',
      {'quantity': quantity},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> clearCart() async {
    final db = await getDatabase();
    await db.delete('cart');
  }

  static Future<void> saveOrder(Order order) async {
    final db = await getDatabase();
    await db.insert(
      'orders',
      order.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
