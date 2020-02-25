import 'package:flutter/material.dart';

class Application extends StatefulWidget {
  const Application({Key key}) : super(key: key);
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  var menuList = <Map>[
    {'name': '订单', 'mobileIcon': 'http://leandc.cn/platform/mainImg/order.png'},
    {
      'name': '快修',
      'mobileIcon': 'http://leandc.cn/platform/mainImg/deviceFix.png'
    },
    {
      'name': '生产',
      'mobileIcon': 'http://leandc.cn/platform/mainImg/production.png'
    },
    {'name': '设置', 'mobileIcon': 'http://leandc.cn/platform/mainImg/set.png'}
  ];
  @override
  Widget build(BuildContext context) {
    return _ApplicationItem(name:menuList[1]['name']);
  }
}

class _ApplicationItem extends StatelessWidget {
  _ApplicationItem({Key key, this.name}) : super(key: key);
  String name;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      padding: EdgeInsets.all(30.0), // 边距
      hoverColor: Colors.black.withOpacity(0.05), // 点击按钮颜色
      onPressed: () {
        // 点击事件
        print('onPressed');
      },
      child: SizedBox(
          height: 100,
          // 用来限制子部件高度
          child: Column(
        // 垂直布局
        children: <Widget>[
          Image.network(
            "http://leandc.cn/platform/mainImg/order.png",
            width: 50,
          ),
          Text(name)
        ],
      )),
    );
  }
}
