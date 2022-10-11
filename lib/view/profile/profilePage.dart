import 'package:flutter/material.dart';

import 'components/profileBody.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Tài khoản"),
      ),
      body: ProfileBody(),
    );
  }
}
