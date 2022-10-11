import 'package:flutter/material.dart';
import 'package:footshop/view/home/homeWidget.dart';
import 'package:footshop/view/profile/profilePage.dart';

import '../../helper/Style.dart';
import '../../services/sharedPreferences.dart';
import '../cart/cartPage.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  Widget _home = homeWidget();
  Widget _myEmails = Container(child: Center(child: Text("Gọi mói")));
  Widget _myProfile = Container(child: Center(child: Text("Yêu thích")));
  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 0),
              child: SizedBox(
                width: 80,
                height: 80,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfilePage()));
                  },
                  child: FutureBuilder(
                    future: getUserDataFromSharedPreferences(),
                    builder: (context, snapshot) {
                      return CircleAvatar(
                        backgroundImage: NetworkImage(snapshot.data?.img ??
                            "https://cdn-icons-png.flaticon.com/512/147/147133.png"),
                      );
                    },
                  ),
                ),
              ),
            )
          ],
          leading: IconButton(
            icon: Icon(
              Icons.search,
              size: 27,
              color: Colors.grey,
            ),
            onPressed: () {},
          )),
      body: this.getBody(),
      bottomNavigationBar: bottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.shopping_bag,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CartPage()));
        },
      ),
    );
  }

  Widget getBody() {
    if (this.selectedIndex == 0) {
      return this._home;
    } else if (this.selectedIndex == 1) {
      return this._myEmails;
    } else {
      return this._myProfile;
    }
  }

  void onTapHandler(int index) {
    this.setState(() {
      this.selectedIndex = index;
    });
  }

  BottomNavigationBar bottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      fixedColor: orange,
      currentIndex: currentIndex,
      onTap: (int index) {
        setState(() {
          currentIndex = index;
        });
        this.onTapHandler(index);
      },
      items: [
        BottomNavigationBarItem(
          label: "Trang chủ",
          icon: Icon(Icons.home_filled),
        ),
        BottomNavigationBarItem(
          label: 'Thực đơn',
          icon: Icon(Icons.restaurant_menu_outlined),
        ),
        BottomNavigationBarItem(
          label: 'Yêu thích',
          icon: Icon(Icons.favorite),
        ),
      ],
    );
  }
}
