import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../common/loading.dart';
import 'package:provider/provider.dart';
import '../model/LoginModel.dart';
import '../model/UserModel.dart';

Dio dio = new Dio();

class ListMenu extends StatefulWidget {
  final String title;
  final String parentid;
  const ListMenu({Key key, @required this.title, @required this.parentid})
      : super(key: key);
  @override
  _ListMenuState createState() => _ListMenuState();
}

class _ListMenuState extends State<ListMenu> {
  List<Map> _menuData = [];
  @override
  void initState() {
    super.initState();
    _getMenuListData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey),
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
      ),
      body: ListView(children: <Widget>[_menuItem(), _menuExpendList()]),
    );
  }

  // 获取菜单
  _getMenuListData() async {
    Future.delayed(Duration.zero, () {
      showLoading(context);
    });
    try {
      Response response = await dio.get(
        "http://leandc.cn/v3/common/rbac/menu",
        queryParameters: {
          "userId": Provider.of<UserModel>(context, listen: false).userId,
          "targetPlatform": "mobileOnly",
          "parentid": widget.parentid
        },
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader:
                Provider.of<LoginModel>(context, listen: false).auth,
          },
        ),
      );
      // 关闭loading
      Navigator.of(context).pop();
      setState(() {
        _menuData = response.data['items'].where((x) =>  x['mobileIcon'] !=null);
      });
      print(_menuData);
    } catch (e) {
      print(e);
      // 关闭loading
      Navigator.of(context).pop();
    }
  }

  Widget _menuItem() {
    return InkWell(
        onTap: () {},
        child: ListTile(
          leading: CircleAvatar(
            radius: 11,
            backgroundImage:
                NetworkImage('https://s2.ax1x.com/2019/08/16/mZeD4P.png'),
          ),
          title: Text('Three-line ListTile'),
          trailing: Icon(Icons.chevron_right),
        ));
  }

  Widget _menuExpendList() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _menuData[index]['isExpanded'] = !isExpanded;
        });
      },
      children: _menuData.map<ExpansionPanel>((item) {
        return ExpansionPanel(
          canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              leading: CircleAvatar(
                radius: 11,
                backgroundImage: NetworkImage(item['mobileIcon']),
              ),
              title: Text(item['name']),
            );
          },
          body: Text('test'),
        );
      }).toList(),
    );
  }
}
