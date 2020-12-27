import 'package:flutter/widgets.dart';

import 'package:todo/data/todo_database.dart';

class TodoModel extends ChangeNotifier {
  final db = TodoDatabase();


  add(TodoItem item) async {

    await db.insertItem(item);

    print('add item suc');

    notifyListeners();
  }

  update(TodoItem item) async {
    await db.updateItem(item);

    notifyListeners();
  }

  delete(int id) async {
    await db.deleteItem(id);

    notifyListeners();
  }

  Future<List<TodoItem>> items() async {
    List<TodoItem> items = await db.todoItems();
    notifyListeners();
    return items;
  }

  Future<TodoItem> getItem(int id) async {
    TodoItem item = await db.getItem(id);
    // notifyListeners();
    return item;
  }
}