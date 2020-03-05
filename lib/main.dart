import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'login.dart';

void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        // 本地化的代理类
        GlobalMaterialLocalizations.delegate, // 提供的本地化的字符串和其他值，它可以使Material 组件支持多语言
        GlobalWidgetsLocalizations.delegate, // 定义组件默认的文本方向
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('zh', 'CN'), // 中文简体
        //其它Locales
      ],
      title: _title,
      home: LoginWidget(),
    );
  }
}
