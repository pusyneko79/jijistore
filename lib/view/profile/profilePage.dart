import 'package:flutter/material.dart';
import 'package:footshop/helper/enums.dart';

import 'components/body.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Tài khoản"),
      ),
      body: Body(),
    );
  }
}
