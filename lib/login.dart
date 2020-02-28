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
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/login_bg.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 140,horizontal: 20),
        child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Color.fromRGBO(255, 255, 255, 0.9)),
            child: MaterialButton(
                child: Text('登录'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomeWidget();
                  }));
                })),
      ),
    );
  }
}
