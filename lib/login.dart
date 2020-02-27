import 'package:flutter/material.dart';
import 'home.dart';

class LoginWidget extends StatefulWidget {
  LoginWidget({Key key}) : super(key: key);
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.asset('images/login_bg.png', fit: BoxFit.fill),
        // MaterialButton(
        //   child:Text('登录'),
        //   onPressed: () {
        //   Navigator.push(context, MaterialPageRoute(builder: (context) {
        //     return HomeWidget();
        //   }));
        // })
      ],
    );
  }
}
