import 'package:flutter/widgets.dart';

import 'package:todo/data/todo_database.dart';

class TodoModel extends ChangeNotifier {
  final db = TodoDatabase();

  TodoModel(){
    db.init();
  }

  add(TodoItem item) async {

    await db.insertItem(item);

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
}