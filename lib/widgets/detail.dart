import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/data/todo_database.dart';
import 'package:todo/data/todo_model.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/detailPage';
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    /// 获取参数
    final int id = ModalRoute.of(context).settings.arguments;

    TodoItem item =
        (id == null) ? null : Provider.of<TodoModel>(context, listen: false).getItem(id);

    String title = '';
    String content = '';

    return Scaffold(
      appBar: AppBar(
        title: Text('DetailPage'),
        actions: <Widget>[
          new IconButton(
              icon: const Icon(Icons.check_outlined),
              onPressed: () {

                TodoItem newItem = TodoItem(
                  id: id,
                  title: title,
                  content: content,
                );
                if(id == null)Provider.of<TodoModel>(context, listen:false).add(newItem);
                else Provider.of<TodoModel>(context, listen:false).update(newItem);

                Navigator.pop(context);
                print('pop suc!');
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Input here',
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Enter the title',
              ),
              maxLength: 15,
              initialValue: item?.title,
              onChanged: (text) => title = text,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Enter the content'),
              maxLines: 12,
              maxLength: 1037,
              initialValue: item?.content,
              onChanged: (text) => content = text,
            ),
          ],
        ),
      ),
    );
  }
}
