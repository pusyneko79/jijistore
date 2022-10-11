import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../helper/storeManager.dart';
import '../../helper/themeManagement.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool? isToggle = false;
  ThemeNotifier themeNotifier = ThemeNotifier();
  @override
  void initState() {
    super.initState();
    StorageManager.readData('themeMode').then((value) {
      if (value == "light") {
        setState(() {
          isToggle = false;
        });
      } else {
        setState(() {
          isToggle = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, theme, _) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("Cài đặt"),
        ),
        body: Row(
          children: [
            SettingsList(
              sections: [
                SettingsSection(
                  title: Text('Cài đặt'),
                  tiles: <SettingsTile>[
                    SettingsTile.switchTile(
                      onToggle: (value) {
                        setState(() {
                          isToggle = !isToggle!;
                        });
                        if (isToggle == true) {
                          print('Set Dark theme');
                          theme.setDarkMode();
                        } else {
                          print('Set Light Theme');
                          theme.setLightMode();
                        }
                      },
                      initialValue: isToggle,
                      leading: Icon(Icons.format_paint),
                      title: Text('Chế độ nền tối'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
