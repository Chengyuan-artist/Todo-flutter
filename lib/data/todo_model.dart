import 'package:flutter/widgets.dart';

import 'package:todo/data/todo_database.dart';

class TodoModel extends ChangeNotifier {
  static const _TAG = 'TodoModel';

  final db = TodoDatabase();
  bool _isInited = false;

  TodoModel() {
    db.init().then((value) {
      _isInited = true;
      notifyListeners();
    });
  }

  /// _items为TodoModel数据
  /// 原则： ui 根据 _items 变动
  List<TodoItem> _items;

  /// id->TodoItem
  /// to find item according to id
  Map<int, TodoItem> _idMap = Map();

  TodoItem getItem(int id) => _idMap[id];

  // 将allItems数据放入Model的_items中
  void _putAll(List<TodoItem> allItems) {
    if (allItems == null) {
      print(_TAG + 'put null into _items');
      return;
    }
    _items = allItems;

    _idMap =
        Map.fromIterable(_items, key: (item) => item.id, value: (item) => item);

    /// 根据index排序
    _items.sort((a, b) => a.itemIndex.compareTo(b.itemIndex));

    _updateIndex(0);

    notifyListeners();
  }

  void _updateIndex(int itemIndex) {
    _items.forEach((element) {
      element.itemIndex = itemIndex++;
    });
  }

  List<TodoItem> getAll() {
    if (_items == null) {
      if (_isInited)
        _getAllInLocal();
      else
        return null;
    }
    return _items;
  }

  void _getAllInLocal() async {
    List<TodoItem> allItems = await db.todoItems();
    _putAll(allItems);
  }

  void reoderItem(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;
    final item = _items.removeAt(oldIndex);
    _items.insert(newIndex, item);

    _updateIndex(0);

    notifyListeners();

    // update the itemIndex in db
    _updateAllInDb(_items);
  }

  void addItem(TodoItem item) {
    item.itemIndex = 0;
    // id?

    _updateIndex(1);

    // update the itemIndex in db

    _insertAndUpdate(item);
  }

  void deleteItem(int id) {
    int index = _idMap[id].itemIndex;
    _items.removeAt(index);

    notifyListeners();
    db.deleteItem(id);
  }

  void updateItem(TodoItem item) {
    int index = _idMap[item.id].itemIndex;
    _items[index] = item;

    notifyListeners();

    db.updateItem(item);
  }

  void _updateAllInDb(List<TodoItem> items) {
    items.forEach((item) {
      db.updateItem(item);
    });
  }

  void _insertAndUpdate(TodoItem item) async {
    await db.insertItem(item);
    _items.forEach((element) async {
      await db.updateItem(element);
    });
    _getAllInLocal();
  }
}
