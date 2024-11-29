import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/user.dart';

class DBHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  // Tables
  static const String userTable = '''
   CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        fullname TEXT,
        email TEXT NOT NULL,
        password TEXT NOT NULL,
        phone TEXT NOT NULL -- Added phone column
      )
   ''';

  static const String rememberMeTable = '''
   CREATE TABLE remember_me (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT NOT NULL,
        password TEXT NOT NULL
      )
   ''';

  static Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'TaskTrackerap');

    return openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute(userTable);
        await db.execute(rememberMeTable);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute("ALTER TABLE users ADD COLUMN phone TEXT NOT NULL DEFAULT ''");
        }
      },
    );
  }

  static Future<int> createUser(User usr) async {
    final Database db = await database;

    final existingUser = await db.query(
      "users",
      where: "email = ?",
      whereArgs: [usr.email],
    );

    if (existingUser.isNotEmpty) {
      return -1;
    } else {
      return await db.insert(
        "users",
        usr.toMap(),
      );
    }
  }

  static Future<bool> authenticate(User usr) async {
    final Database db = await database;
    var result = await db.rawQuery(
        "SELECT * FROM users WHERE email = '${usr.email}' AND password = '${usr.password}'");

    if (result.isNotEmpty) {
      await saveUserData(usr.email, usr.password);
      return true;
    } else {
      return false;
    }
  }

  static Future<List<Map<String, Object?>>?> queryUsers() async {
    return await _database?.query('users');
  }

  static Future<User?> getUserByEmail(String email) async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  static Future<int> updateUser(User user) async {
    final Database db = await database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  static Future<int> deleteUser(String email) async {
    final db = await database;
    return await db.delete('users', where: 'email = ?', whereArgs: [email]);
  }

  static Future<void> saveUserData(String email, String password) async {
    final Database db = await database;
    await db.delete('remember_me');
    await db.insert(
      'remember_me',
      {'email': email, 'password': password},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<Map<String, String>?> getUserData() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('remember_me');
    if (maps.isNotEmpty) {
      return {'email': maps.first['email'], 'password': maps.first['password']};
    }
    return null;
  }

  static Future<int> getUserCount() async {
    final db = await database;
    var res = await db.rawQuery('SELECT COUNT(*) FROM users');
    int count = Sqflite.firstIntValue(res) ?? 0;
    return count;
  }

  static Future<void> clearUserData() async {
    final Database db = await database;
    await db.delete('remember_me');
  }
}
