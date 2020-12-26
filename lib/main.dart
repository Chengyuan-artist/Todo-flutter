import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/data/todo_model.dart';
import 'package:todo/widgets/detail.dart';
import 'package:todo/widgets/list.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TodoModel(),
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ListPage(),
      routes: {
        ListPage.routeName: (context) => ListPage(),
        DetailPage.routeName: (context) => DetailPage(),
      },
    );
  }
}
