import 'package:flutter/material.dart';
import 'package:footshop/view/product/foodDetailPage.dart';
import 'package:footshop/helper/style.dart';
import 'package:footshop/view/login/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'mont'),
      home: LoginPage(),
    );
  }
}
