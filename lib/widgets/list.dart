import 'package:flutter/material.dart';
import 'package:todo/data/todo_database.dart';
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hello, Todoer!',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, DetailPage.routeName),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  dbTest(){
    var db = TodoDatabase();
    db.init();
  }
}
