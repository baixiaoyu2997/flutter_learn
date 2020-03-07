import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

Dio dio = new Dio();
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
  void initState() {
    super.initState();
    getMenu();
  }
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        padding: EdgeInsets.only(top: 20, left: 10, right: 8), // 边距
        crossAxisCount: 3, // 设置Grid布局为3列
        childAspectRatio: 0.8, // 子部件表格宽高比
        children: List<Widget>.generate(menuList.length, (int rowIndex) {
          return _ApplicationItem(menu: menuList[rowIndex]);
        }));
  }
   getMenu()async {
      Response response = await dio
            .post("https://hwdc-17.leandc.cn/v3/common/jwt_auth", data: {
          "userId": "05J4BP8GPR2DSWY1",
          "targetPlatform": "mobileOnly"
        });
        print(response);
  }
}

class _ApplicationItem extends StatelessWidget {
  _ApplicationItem({Key key, this.menu}) : super(key: key);
  final Map menu;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
        // 优化性能，局部渲染
        child: RawMaterialButton(
            // 按钮部件
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 27.0), // 边距
            hoverColor: Colors.black.withOpacity(0.05), // 点击按钮颜色
            onPressed: () {
              // 点击事件
              print('onPressed');
            },
            child: Column(
              // Column布局
              mainAxisSize: MainAxisSize.min, // 主轴大小
              // 垂直布局
              children: <Widget>[
                Image.network(
                  // 图片
                  menu['mobileIcon'],
                ),
                SizedBox(
                  // 间隔
                  height: 10,
                ),
                Text(menu['name'], style: TextStyle(fontSize: 18)) // 文字
              ],
            )));
  }
}
