import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  static const routeName = '/detailPage';
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DetailPage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Input here',
            ),
          ],
        ),
      ),
    );
  }
}
