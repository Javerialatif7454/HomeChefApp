import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HaleemDBHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  static Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'haleem.db'),
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE haleem_items (
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

  static Future<void> toggleFavorite(String imagePath, bool isFavorite) async {
    final db = await database;

    final existingItem = await db.query(
      'haleem_items',
      where: 'imagePath = ?',
      whereArgs: [imagePath],
    );

    if (existingItem.isNotEmpty) {
      await db.update(
        'haleem_items',
        {'isFavorite': isFavorite ? 1 : 0},
        where: 'imagePath = ?',
        whereArgs: [imagePath],
      );
    } else {
      // Insert new item
      await db.insert('haleem_items', {
        'imagePath': imagePath,
        'title': '',
        'price': '',
        'isFavorite': isFavorite ? 1 : 0,
      });
    }
  }

  static Future<bool> isFavorite(String imagePath) async {
    final db = await database;
    final result = await db.query(
      'haleem_items',
      where: 'imagePath = ? AND isFavorite = 1',
      whereArgs: [imagePath],
    );
    return result.isNotEmpty;
  }
}
