import 'package:flutter/material.dart';
import 'package:path/path.dart';
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
    // dbTest();
    return Scaffold(
      appBar: AppBar(
        title: Text('ListPage'),
      ),
      body: Consumer<TodoModel>(builder: (context, model, child) {
        List<TodoItem> _items;
        model.items().then((value) {
          _items = value;
        });

        if (_items == null) {
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

        final Iterable<ListTile> tiles = _items?.map((item) {
          if (item == null) return null;
          return ListTile(
            title: Text(item.title),
          );
        });

        final List<Widget> divided = ListTile.divideTiles(
          context: context,
          tiles: tiles,
        ).toList();

        return ListView(
          children: divided,
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, DetailPage.routeName),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  dbTest() {
    var db = TodoDatabase();
    db.init();
  }
}
