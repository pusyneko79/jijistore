import 'dart:async';

import 'package:flutter/material.dart';
import 'package:footshop/helper/bezierContainer.dart';
import 'package:footshop/model/userRegisterModel.dart';
import 'package:footshop/view/login/Login.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../services/apiService.dart';

enum DialogType {
  success,
  fail,
  loading;
}

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();

  bool isRequesting = false;

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Quay lại',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

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
        if (await createUser(UserRegisterModel(
              1,
              _nameController.text,
              _addressController.text,
              18,
              "img",
              _emailController.text,
              _passwordController.text,
              _phoneController.text,
            )) ==
            200) {
          print("Success");
          setState(() {
            isRequesting = false;
            Timer(const Duration(seconds: 1), () {
              Navigator.pop(context);
              showLoaderDialog(context, DialogType.success, () {});
            });
          });
        } else {
          print("Fail");
          setState(() {
            isRequesting = false;
            Timer(const Duration(seconds: 1), () {
              Navigator.pop(context);
              showLoaderDialog(context, DialogType.fail, () {});
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
          'Đăng ký',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Đã có tài khoản ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Đăng nhập',
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
          text: 'JiJi',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xffe46b10)),
          children: [
            TextSpan(
              text: ' Store',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField(
          _emailController,
          "Email",
        ),
        _entryField(_nameController, "Họ và tên"),
        _entryField(_phoneController, "Số điện thoại"),
        _entryField(_addressController, "Địa chỉ"),
        _entryField(_passwordController, "Password", isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SizedBox(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),
                    SizedBox(
                      height: 50,
                    ),
                    _emailPasswordWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    _submitButton(),
                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}

showLoaderDialog(
    BuildContext context, DialogType dialogType, VoidCallback? onPress) {
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
    content: SizedBox(
      height: 100,
      width: 100,
      child: Center(
          child: Icon(
        Icons.delete,
        color: Colors.red,
        size: 80,
      )),
    ),
    actions: <Widget>[
      TextButton(
        onPressed: () => Navigator.pop(context, 'OK'),
        child: const Text('OK'),
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
