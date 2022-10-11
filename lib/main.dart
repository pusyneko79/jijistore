import 'package:flutter/material.dart';
import 'package:footshop/view/product/foodDetailPage.dart';
import 'package:footshop/helper/style.dart';
import 'package:footshop/view/login/login.dart';
import 'package:provider/provider.dart';

import 'helper/themeManagement.dart';

void main() {
  return runApp(ChangeNotifierProvider<ThemeNotifier>(
    create: (_) => new ThemeNotifier(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
        builder: (context, theme, _) => MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: theme.getTheme(),
              home: LoginPage(),
            ));
  }
}
