import 'package:flutter/material.dart';
import 'package:footshop/view/profile/profileDetailPage.dart';
import 'package:footshop/view/setting/settingPage.dart';

import '../../login/Login.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "Tài khoản",
            icon: "asset/icons/UserIcon.svg",
            press: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileDetailPage()))
            },
          ),
          ProfileMenu(
            text: "Cài đặt",
            icon: "asset/icons/Settings.svg",
            press: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Setting()));
            },
          ),
          ProfileMenu(
            text: "Hỗ trợ",
            icon: "asset/icons/Questionmark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Đăng xuất",
            icon: "asset/icons/Logout.svg",
            press: (() {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route route) => false);
            }),
          ),
        ],
      ),
    );
  }
}
