import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FavoritesService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await openDatabase(
      join(await getDatabasesPath(), 'favorites.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE favorites(id INTEGER PRIMARY KEY, name TEXT, price TEXT, image TEXT)',
        );
      },
      version: 1,
    );
    return _database!;
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    final db = await database;
    return await db.query('favorites');
  }

  Future<void> deleteFavorite(int id) async {
    final db = await database;
    await db.delete(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> addFavorite(Map<String, dynamic> favorite) async {
    final db = await database;
    await db.insert(
      'favorites',
      favorite,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
