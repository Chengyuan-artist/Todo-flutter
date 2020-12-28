import 'dart:collection';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TodoItem {
  final int id;
  String creatingTime;
  String updatingTime;
  String title;
  String content;
  int itemIndex;
  TodoItem(
      {this.id,
      this.creatingTime,
      this.updatingTime,
      this.title,
      this.content,
      this.itemIndex});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'creatingTime': creatingTime,
      'updatingTime': updatingTime,
      'itemIndex': itemIndex,
    };
  }
}

class TodoDatabase {
  Future<Database> database;

  static TodoDatabase _instance;

  factory TodoDatabase() => _getInstance();

  static TodoDatabase _getInstance() {
    if (_instance == null) {
      _instance = TodoDatabase._internal();
    }
    print('already get an instance');
    return _instance;
  }

  TodoDatabase._internal() {
    print("Todo db initialized");
  }

  Future init() async {
    String path = await getDatabasesPath();
    database = openDatabase(
      join(path, 'todo_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE todos(id INTEGER PRIMARY KEY, title TEXT, content TEXT, creatingTime TEXT, updatingTime TEXT, itemIndex INTEGER)",
        );
      },
      version: 1,
    );
    print('db init()');
  }

  insertItem(TodoItem item) async {
    final Database db = await database;
    await db.insert(
      'todos',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('db insert suc');
  }

  Future<List<TodoItem>> todoItems() async {
    final Database db = await database;

    final maps = await db.query('todos');

    return List.generate(
        maps.length,
        (i) => TodoItem(
              id: maps[i]['id'],
              title: maps[i]['title'],
              content: maps[i]['content'],
              creatingTime: maps[i]['creatingTime'],
              updatingTime: maps[i]['updatingTime'],
              itemIndex: maps[i]['itemIndex'],
            ));
  }

  Future<int> updateItem(TodoItem item) async {
    final Database db = await database;

    return await db.update(
      'todos',
      item.toMap(),
      where: "id = ?",
      whereArgs: [item.id],
    );
  }

  deleteItem(int id) async {
    final Database db = await database;

    await db.delete(
      'todos',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<TodoItem> getItem(int id) async {
    final Database db = await database;

    final map = await db.query(
      'todos',
      where: "id = ?",
      whereArgs: [id],
    );

    //数据库中不含此id
    if (map.length == 0) return null;

    final item = TodoItem(
      id: map[0]['id'],
      title: map[0]['title'],
      content: map[0]['content'],
      creatingTime: map[0]['creatingTime'],
      updatingTime: map[0]['updatingTime'],
      itemIndex: map[0]['itemIndex'],
    );

    return item;
  }
}
