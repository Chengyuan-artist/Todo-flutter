import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/data/todo_database.dart';
import 'package:todo/data/todo_model.dart';
import 'package:todo/widgets/detail.dart';

class ListPage extends StatefulWidget {
  static const routeName = '/listPage';
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListPage'),
      ),
      body: Consumer<TodoModel>(builder: (context, model, child) {
        List<TodoItem> _items = model.getAll();

        // 如果数据库中没有数据
        if (_items == null || _items.length == 0) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Hello, Todoer!',
                ),
              ],
            ),
          );
        }

        final Iterable<Dismissible> tiles = _items.map((item) {
          return Dismissible(
              background: Container(
                color: Colors.red,
              ),
              key: Key(item.id.toString()),
              onDismissed: (direction) {
                model.deleteItem(item.id);
                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text("item ${item.id} dismissed")));
              },
              child: ListTile(
                key: Key(item.id.toString()),
                title: Text(item.title?? ''),
                onTap: () => _navigateToDetail(item.id),
              ));
        });

        return ReorderableListView(
            children: tiles.toList(),
            onReorder: (int oldIndex, int newIndex) =>
                model.reoderItem(oldIndex, newIndex));
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, DetailPage.routeName),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _navigateToDetail(int id) {
    print('ontap : $id');
    Navigator.pushNamed(context, DetailPage.routeName, arguments: id);
  }
}
