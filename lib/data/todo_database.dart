import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TodoItem {
  final int id;
  final String creatingTime;
  final String updatingTime;
  final String title;
  final String content;
  TodoItem(
      {this.id,
      this.creatingTime,
      this.updatingTime,
      this.title,
      this.content});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'creatingTime': creatingTime,
      'updatingTime': updatingTime,
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

  init() async {
    String path = await getDatabasesPath();
    database = openDatabase(
      join(path, 'todo_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE todos(id INTEGER PRIMARY KEY, title TEXT, content TEXT, creatingTime TEXT, updatingTime TEXT)",
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
  }

  todoItems() async {
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
            ));
  }

  updateItem(TodoItem item) async {
    final Database db = await database;

    await db.update(
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
}
