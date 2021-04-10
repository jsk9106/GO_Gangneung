import 'dart:io';

import 'package:go_gangneung/model/favorite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final String tableName = 'favorite';

class DBHelper {

  DBHelper._();
  static final DBHelper _db = DBHelper._();
  factory DBHelper() => _db;

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'MyFavorite.db');

    return await openDatabase(
        path,
        version: 1,
        onCreate: (db, version) async {
          await db.execute(
            "CREATE TABLE $tableName(contentId INTEGER PRIMARY KEY, readCount INTEGER, title TEXT, address TEXT, firstImage TEXT, mapX REAL, mapY REAL, tel TEXT, contentTypeId INTEGER)"
          );
        },
        // onUpgrade: (db, oldVersion, newVersion){}
    );
  }

  //Create
  createData(favorite) async {
    final db = await database;
    var res = await db.insert(tableName, favorite.toJson());
    return res;
  }

  //Read
  getFavorite(int contentId) async {
    final db = await database;
    var res = await db.query(tableName, where: 'contentId = ?', whereArgs: [contentId]);
    return res.isNotEmpty ? Favorite.fromJson(res.first) : Null;
  }

  //Read All
  Future<List<Favorite>> getAllFavorites() async {
    final db = await database;
    var res = await db.query(tableName);
    try{
      List<Favorite> list = res.isNotEmpty ? res.map((e) => Favorite.fromJson(e)).toList() : [];
      return list;
    }catch(err){
      print(err);
    }
  }

  //Delete
  deleteFavorite(int contentId) async {
    final db = await database;
    var res = db.delete(tableName, where: 'contentId = ?', whereArgs: [contentId]);
    return res;
  }

  //Delete All
  deleteAllFavorites() async {
    final db = await database;
    db.delete(tableName);
  }

  deleteTable() async {
    final db = await database;
    await db.execute("DROP TABLE IF EXISTS $tableName");
  }

}