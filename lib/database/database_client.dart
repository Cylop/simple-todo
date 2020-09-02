import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/model/todo_item.dart';

class DatabaseHelper {
  String tableName = "todo";
  String columnId = "id";
  String columnItemName = "name";
  String columnDescription = "description";
  String columnDataCreated = "creationDate";
  String columnDateCompleted = "completionDate";
  String columnTags = "tags";
  String columnIsDone = "isDone";

  static Database _db;

  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "simple_todo_data.db");
    var ourDB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDB;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnItemName TEXT, $columnDescription TEXT, $columnDataCreated TEXT, $columnDateCompleted TEXT, $columnTags TEXT, $columnIsDone INTEGER)");
    print("Database Created"); // Yaaaaaaaaaaay!
  }

  Future<int> saveItem(ToDoItem item) async {
    var dbClient = await db;
    int res = await dbClient.insert("$tableName", item.toMap());
    return res;
  }

  Future<List> getItems() async {
    var dbClient = await db;
    var result = await dbClient
        .rawQuery("SELECT * FROM $tableName ORDER BY $columnIsDone DESC, $columnId ASC, $columnItemName ASC");
    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;
    return Sqflite
        .firstIntValue(await dbClient.rawQuery("SELECT COUNT (*) FROM $tableName"));
  }

  Future<ToDoItem> getItem(int id) async {
    var dbClient = await db;
    var result = await dbClient
        .rawQuery("SELECT * FROM $tableName WHERE $columnId = $id");
    if (result.length == 0) return null;
    return ToDoItem.fromMap(result.first);
  }

  Future<int> deleteItem(int id) async {
    var dbClient = await db;
    return await dbClient.rawDelete("DELETE FROM $tableName WHERE $columnId = ?", [id]);
  }

  Future<int> updateItem(ToDoItem item) async{
    var dbClient = await db;
    return await dbClient.update("$tableName", item.toMap() , where: "$columnId = ?" , whereArgs: [item.getId]);
  }

  Future close() async {
    var dbClient = await db;
    return await dbClient.close();
  }
}