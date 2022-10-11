import 'package:flutter/material.dart';
import 'package:footshop/helper/storeManager.dart';
import 'package:footshop/helper/style.dart';

class ThemeNotifier with ChangeNotifier {
  final darkTheme = ThemeData(
    appBarTheme:
        AppBarTheme(color: Colors.black38, foregroundColor: Colors.white),
    toggleableActiveColor: Colors.orange,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange)
        .copyWith(secondary: orange, brightness: Brightness.dark),
  );

  final lightTheme = ThemeData(
    appBarTheme:
        AppBarTheme(color: Colors.white, foregroundColor: Colors.black),
    primaryColor: Colors.white,
    brightness: Brightness.light,
    backgroundColor: const Color(0xFFE5E5E5),
    dividerColor: Colors.white54,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
        .copyWith(secondary: Colors.black),
  );

  ThemeData? _themeData;
  ThemeData? getTheme() => _themeData;

  ThemeNotifier() {
    StorageManager.readData('themeMode').then((value) {
      print('value read from storage: ' + value.toString());
      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _themeData = lightTheme;
      } else {
        print('setting dark theme');
        _themeData = darkTheme;
      }
      notifyListeners();
    });
  }

  bool? isDarkMode() {
    StorageManager.readData('themeMode').then((value) {
      if (value.toString() != "light") {
        return true;
      } else {
        return false;
      }
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }
}
