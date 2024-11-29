import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  static Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'favorite_items.db'),
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE favorite_items (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            imagePath TEXT NOT NULL,
            title TEXT NOT NULL,
            price TEXT NOT NULL,
            isFavorite INTEGER DEFAULT 0
          )
        ''');
      },
      version: 1,
    );
  }

  static Future<void> insertItem(String imagePath, String title, String price) async {
    final db = await database;

    await db.insert(
      'favorite_items',
      {
        'imagePath': imagePath,
        'title': title,
        'price': price,
        'isFavorite': 1,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteItem(String imagePath) async {
    final db = await database;

    await db.delete(
      'favorite_items',
      where: 'imagePath = ?',
      whereArgs: [imagePath],
    );
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await database;

    final List<Map<String, dynamic>> result = await db.query(
      'favorite_items',
      where: 'isFavorite = 1',
    );

    return result;
  }

  static Future<bool> isFavorite(String imagePath) async {
    final db = await database;

    final result = await db.query(
      'favorite_items',
      where: 'imagePath = ? AND isFavorite = 1',
      whereArgs: [imagePath],
    );

    return result.isNotEmpty;
  }
  static Future<List<Map<String, dynamic>>> searchItems(String query) async {
    final db = await database;

    final List<Map<String, dynamic>> result = await db.query(
      'favorite_items',
      where: 'title LIKE ? AND isFavorite = 1',
      whereArgs: ['%$query%'],
    );

    return result;
  }
  static Future<void> toggleFavorite(String imagePath, String title, String price, bool isFavorite) async {
    final db = await database;

    final existingItem = await db.query(
      'favorite_items',
      where: 'imagePath = ?',
      whereArgs: [imagePath],
    );

    if (existingItem.isNotEmpty) {
      await db.update(
        'favorite_items',
        {'isFavorite': isFavorite ? 1 : 0},
        where: 'imagePath = ?',
        whereArgs: [imagePath],
      );
    } else {
      await insertItem(imagePath, title, price);
    }
  }
}
