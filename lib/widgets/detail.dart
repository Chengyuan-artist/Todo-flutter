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
    print("get the id $id");

    TodoItem _item = Provider.of<TodoModel>(context, listen: false).getItem(id)?? TodoItem();

    return Scaffold(
      appBar: AppBar(
        title: Text('DetailPage'),
        actions: <Widget>[
          new IconButton(
              icon: const Icon(Icons.check_outlined),
              onPressed: () {
                if (id == null)
                  Provider.of<TodoModel>(context, listen: false).addItem(_item);
                else
                  Provider.of<TodoModel>(context, listen: false).updateItem(_item);
                Navigator.pop(context);
                print('pop suc!');
              })
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Consumer<TodoModel>(
            builder: (context, model, child) {
              
              return Column(
                children: <Widget>[
                  Text(
                    'Input here',
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter the title',
                    ),
                    maxLength: 15,
                    initialValue: _item.title,
                    onChanged: (text) => _item.title = text,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Enter the content'),
                    maxLines: 12,
                    maxLength: 1037,
                    initialValue: _item.content,
                    onChanged: (text) => _item.content = text,
                  ),
                ],
              );
            },
          )),
    );
  }
}
