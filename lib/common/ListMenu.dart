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
  List<dynamic> _menuData = [];
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
      body: ListView(children: _menuItem()),
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
      // 过滤无用数据
      List<dynamic> filterData = response.data['items']
          .where((x) => x['mobileIcon'] != null && x['dataType'] == 'function')
          .toList();
      // 默认都是关闭状态
      for (var item in filterData) {
        item['isExpanded'] = false;
      }
      setState(() {
        _menuData = filterData;
      });
    } catch (e) {
      print(e);
      // 关闭loading
      Navigator.of(context).pop();
    }
  }

  List<Widget> _menuItem() {
    return _menuData.map((item) {
     return Material(
        color: Colors.white,
        child: InkWell(
            onTap: () {},
            child: ListTile(
              leading: CircleAvatar(
                radius: 11,
                backgroundImage:
                    NetworkImage(item['mobileIcon']),
              ),
              title: Text(item['name']),
              trailing: Icon(Icons.chevron_right),
            )),
      );
    }).toList();
  }

  // Widget _menuExpendList() {
  //   return ExpansionPanelList(
  //     expansionCallback: (int index, bool isExpanded) {
  //       if (index.isEven) {
  //         setState(() {
  //           print(isExpanded);
  //           _menuData[index]['isExpanded'] = !isExpanded;
  //         });
  //       }
  //     },
  //     children: _menuData.map<ExpansionPanel>((item) {
  //       return ExpansionPanel(
  //           canTapOnHeader: true,
  //           headerBuilder: (BuildContext context, bool isExpanded) {
  //             print(context);
  //             return ListTile(
  //               leading: CircleAvatar(
  //                 radius: 11,
  //                 backgroundImage: NetworkImage(item['mobileIcon']),
  //               ),
  //               title: Text(item['name']),
  //             );
  //           },
  //           body: Text('test'),
  //           isExpanded: item['isExpanded']);
  //     }).toList(),
  //   );
  // }
}
