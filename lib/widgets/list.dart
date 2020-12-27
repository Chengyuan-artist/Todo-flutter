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
  List<TodoItem> _items;
  @override
  Widget build(BuildContext context) {
    // dbTest();

    return Scaffold(
      appBar: AppBar(
        title: Text('ListPage'),
      ),
      body: Consumer<TodoModel>(builder: (context, model, child) {
        ///working around 系统会自动反复“刷新”，访问数据库
        /// ？存疑 行为到底是什么
        model.items().then((value) {
          _items = value;
        });
        // 如果数据库中没有数据
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

        final Iterable<ListTile> tiles = _items.map((item) {
          if (item == null) return null;
          return ListTile(
            title: Text(item.title),
            onTap: () => _navigateToDetail(item.id),
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

  _navigateToDetail(int id){
      print('ontap : $id');
      Navigator.pushNamed(context, DetailPage.routeName, arguments: id);
  }
}
