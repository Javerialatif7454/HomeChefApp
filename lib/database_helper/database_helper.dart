import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = 'favorites.db';
  static const _databaseVersion = 1;

  static const table = 'favorites';
  static const columnId = 'id';
  static const columnDescription = 'description';

  // Singleton instance
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Singleton database
  static Database? _database;

  DatabaseHelper._privateConstructor();

  // Open the database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  // Create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnDescription TEXT NOT NULL
      )
    ''');
  }

  // Insert a favorite item
  Future<int> insertFavorite(Map<String, String> item) async {
    Database db = await database;
    return await db.insert(table, item);
  }

  // Remove a favorite item
  Future<int> removeFavorite(String description) async {
    Database db = await database;
    return await db.delete(
      table,
      where: '$columnDescription = ?',
      whereArgs: [description],
    );
  }

  // Get all favorite items
  Future<List<Map<String, dynamic>>> getFavorites() async {
    Database db = await database;
    return await db.query(table);
  }
}
