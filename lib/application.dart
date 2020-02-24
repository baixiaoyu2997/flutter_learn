import 'package:flutter/material.dart';

class Application extends StatefulWidget {
  const Application({Key key}) : super(key: key);
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  List<Map> menuList = [{}];
  @override
  Widget build(BuildContext context) {
    return _ApplicationItem();
  }
}

class _ApplicationItem extends StatelessWidget {
  _ApplicationItem({Key key, this.menu}) : super(key: key);
  final Map menu;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      padding:EdgeInsets.all(10.0),
      onPressed: null,
      child:Column(
        children: <Widget>[
          Expanded(child:Text('文字'))
        ],
      )
    );
  }
}
