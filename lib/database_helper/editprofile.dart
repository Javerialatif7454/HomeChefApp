import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // Create the database if it doesn't exist
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_profile.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE user_profile(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          email TEXT,
          phone TEXT,
          address TEXT
        )
      ''');
    });
  }

  Future<void> insertOrUpdateProfile(Map<String, dynamic> profileData) async {
    final db = await database;
    var existingProfile = await db.query(
      'user_profile',
      where: 'id = ?',
      whereArgs: [1],
    );

    if (existingProfile.isEmpty) {
      await db.insert('user_profile', profileData);
    } else {

      await db.update(
        'user_profile',
        profileData,
        where: 'id = ?',
        whereArgs: [1],
      );
    }
  }

  // Get the user profile
  Future<Map<String, dynamic>?> getProfile() async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query('user_profile');
    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }
}
