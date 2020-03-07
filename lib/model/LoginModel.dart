import 'package:flutter/material.dart';

// 定义需要共享的数据模型，通过混入 ChangeNotifier 管理听众
class LoginModel with ChangeNotifier {
  String auth = '';
  
  // 写方法
  void update(value) {
    auth = 'Bearer' + value;
    notifyListeners(); // 通知听众刷新
  }
}
