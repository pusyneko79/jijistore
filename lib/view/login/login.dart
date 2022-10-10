import 'dart:async';

import 'package:flutter/material.dart';
import 'package:footshop/services/apiService.dart';
import 'package:footshop/view/home/homePage.dart';
import 'package:footshop/view/login/signup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../helper/bezierContainer.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isRequesting = false;
  Widget _entryField(TextEditingController controller, String title,
      {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: controller,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return TextButton(
      onPressed: () async {
        setState(() {
          isRequesting = true;
        });
        if (isRequesting == true) {
          showLoaderDialog(context, DialogType.loading, () {});
        }
        var res = await login(
          _emailController.text,
          _passwordController.text,
        );
        if (res == "") {
          print("Success");
          setState(() {
            isRequesting = false;
            Timer(const Duration(seconds: 1), () {
              Navigator.pop(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => MyHomePage()));
            });
          });
        } else {
          print("Fail");
          setState(() {
            isRequesting = false;
            Timer(const Duration(seconds: 1), () {
              Navigator.pop(context);
              showLoaderDialog(context, DialogType.fail, () {},
                  content: res.toString());
            });
          });
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: Text(
          'Đăng nhập',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Không có tài khoản ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Đăng ký',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'JiJi ',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xffe46b10)),
          children: [
            TextSpan(
              text: 'Shop',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField(_emailController, "Email"),
        _entryField(_passwordController, "Mật khẩu", isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer()),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .2),
                  _title(),
                  SizedBox(height: 50),
                  _emailPasswordWidget(),
                  SizedBox(height: 20),
                  _submitButton(),
                  SizedBox(height: 20),
                  _divider(),
                  _createAccountLabel(),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

showLoaderDialog(
    BuildContext context, DialogType dialogType, VoidCallback? onPress,
    {String? content}) {
  AlertDialog loading = AlertDialog(
    elevation: 0,
    backgroundColor: Colors.transparent,
    actions: <Widget>[
      Center(
        child: LoadingAnimationWidget.beat(
          color: Colors.white,
          size: 50,
        ),
      ),
    ],
  );

  AlertDialog success = AlertDialog(
    elevation: 0,
    backgroundColor: Colors.white,
    content: SizedBox(
      height: 100,
      width: 100,
      child: Center(
          child: Icon(
        Icons.check_circle,
        color: Colors.green,
        size: 100,
      )),
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text("Hủy bỏ"),
      ),
      TextButton(
        onPressed: () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage())),
        child: const Text('Đăng nhập'),
      ),
    ],
  );

  AlertDialog fail = AlertDialog(
    elevation: 0,
    backgroundColor: Colors.white,
    icon: Center(
        child: Icon(
      Icons.highlight_off,
      color: Colors.red,
      size: 80,
    )),
    content: SizedBox(
        height: 50, width: 100, child: Center(child: Text(content ?? ""))),
    actions: <Widget>[
      TextButton(
        style: TextButton.styleFrom(
            fixedSize: Size(MediaQuery.of(context).size.width, 50)),
        onPressed: () => Navigator.pop(context, 'OK'),
        child: const Text(
          'OK',
          style: TextStyle(color: Colors.black),
        ),
      ),
    ],
  );

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      switch (dialogType) {
        case DialogType.success:
          return success;
        case DialogType.fail:
          return fail;
        case DialogType.loading:
          return loading;
      }
    },
  );
}
