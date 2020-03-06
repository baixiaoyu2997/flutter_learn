import 'package:flutter/material.dart';
import 'home.dart';
import 'package:dio/dio.dart';
import './common/loading.dart';
import 'package:fluttertoast/fluttertoast.dart';

Dio dio = new Dio();

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
      child: FractionallySizedBox(
        widthFactor: 0.93,
        heightFactor: 0.68,
        child: _LoginForm(),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  _LoginForm({Key key}) : super(key: key);
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  List titleList = ['验证码登录', '密码登录'];
  int activeTab = 1;
  final Color activedColor = Color(0xff2248ec);

  changeActiveTab(index) {
    setState(() {
      activeTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Color.fromRGBO(255, 255, 255, 0.95),
      ),
      child: DefaultTabController(
        length: titleList.length,
        initialIndex: activeTab,
        child: new Scaffold(
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(30),
            child: AppBar(
              backgroundColor: Colors.transparent,
              // centerTitle: true,
              elevation: 0.0, //导航栏下面阴影
              flexibleSpace: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[_buildTabBar()],
              ),
            ),
          ),
          body: _FormWidget(),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      isScrollable: false, //是否可滑动
      unselectedLabelColor: Color(0xff61656b), //未选中文字颜色
      labelColor: activedColor, //选中文字颜色
      labelStyle: TextStyle(fontSize: 18), //文字样式
      indicatorSize:
          TabBarIndicatorSize.label, //滑块指示器宽度是根据内容来适应,还是与整块那么大(label表示根据内容来适应)
      indicatorWeight: 2.0, //滑块高度
      indicatorColor: activedColor, //滑动颜色
      indicatorPadding: EdgeInsets.only(bottom: 1), //与底部距离为1
      onTap: changeActiveTab,
      tabs: titleList.map((text) {
        //tabs表示具体的内容,是一个数组
        return new Tab(
          text: text,
        );
      }).toList(),
    );
  }
}

class _FormWidget extends StatefulWidget {
  _FormWidget({Key key}) : super(key: key);
  bool _hidePassWord = true;
  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<_FormWidget> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 20),
      child: FractionallySizedBox(
        widthFactor: 0.93,
        child: Form(
          key: _formKey,
          // autovalidate: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                // autofocus: true,
                controller: _phoneController,
                decoration: InputDecoration(hintText: "请输入手机号"),
                validator: (v) {
                  return v.trim().isNotEmpty ? null : '手机号不能为空';
                },
              ),
              Stack(
                children: <Widget>[
                  TextFormField(
                    controller: _pwdController,
                    obscureText: widget._hidePassWord,
                    decoration: InputDecoration(hintText: "请输入密码"),
                    validator: (v) {
                      return v.trim().isNotEmpty ? null : '密码不能为空';
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      GestureDetector(
                        // 手势检测
                        child: Icon(
                          widget._hidePassWord
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Color(0xffa2a7a8),
                        ),
                        onTap: () {
                          print(widget._hidePassWord);
                          setState(() {
                            widget._hidePassWord = !widget._hidePassWord;
                          });
                        },
                      ),
                      OutlineButton(
                        onPressed: () {},
                        child: Text('忘记密码'),
                        textColor: Color(0xff4a4a4a),
                        borderSide:
                            BorderSide(width: 2.0, style: BorderStyle.none),
                      ),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: gradientButton(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text('没有账号？', style: TextStyle(color: Color(0xff95999f))),
                    Text('立即注册', style: TextStyle(color: Color(0xff2248ec)))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // 登录按钮
  Widget gradientButton() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xff144bfe), Color(0xff0e81ff)]), // 渐变色
          borderRadius: BorderRadius.circular(5)),
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        color: Colors.transparent, // 设为透明色
        elevation: 0, // 正常时阴影隐藏
        highlightElevation: 0, // 点击时阴影隐藏
        onPressed: () async {
          if ((_formKey.currentState as FormState).validate()) {
            showLoading(context);
            try {
              Response response = await dio
                  .post("https://hwdc-17.leandc.cn/v3/common/jwt_auth", data: {
                "appid": "app:mybaas",
                "provider": "password",
                "token": "${_phoneController.text}::${_pwdController.text}",
                "imageCode": ""
              });
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                return HomeWidget();
              }));
            } catch (error) {
              Navigator.of(context).pop();
              Fluttertoast.showToast(
                  msg: '用户名密码错误',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIos: 1,
                  backgroundColor: Color.fromRGBO(0, 0, 0, 0.9),
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }
        },
        child: Container(
          alignment: Alignment.center,
          height: 50,
          child: Text(
            '登 录',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
