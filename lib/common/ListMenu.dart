import 'package:flutter/material.dart';

class ListMenu extends StatefulWidget {
  final String title;
  final String parentid;
  const ListMenu({Key key, @required this.title, @required this.parentid})
      : super(key: key);
  @override
  _ListMenuState createState() => _ListMenuState();
}

class _ListMenuState extends State<ListMenu> {
  List menuList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child:Text(widget.parentid)
      ),
    );
  }
}
