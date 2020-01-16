import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  DatabaseConnection._();

  static final db = DatabaseConnection._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'todo_database.db'),
      onOpen: (db) {},
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE todolist(id INTEGER PRIMARY KEY, title TEXT, description TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertItem(ToDoItem toDoItem) async {
    final Database db = await database;

    var res = await db.insert(
      'todolist',
      toDoItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return res;
  }

  Future<List<ToDoItem>> getToDoItems() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('todolist');

    return List.generate(maps.length, (i) {
      return ToDoItem(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
      );
    });
  }

  Future<void> deleteToDOItem(int id) async {
    final db = await database;

    await db.delete(
      'todolist',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> upDateToDoItem(ToDoItem toDoItem) async {
    final db = await database;
    var response = await db.update("todolist", toDoItem.toMap(),
        where: "id = ?", whereArgs: [toDoItem.id]);
    return response;
  }
}

class ToDoItem {
  final int id;
  final String title;
  final String description;

  ToDoItem({this.id, this.title, this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  @override
  String toString() {
    return 'Item{id: $id, title: $title, description: $description}';
  }
}
