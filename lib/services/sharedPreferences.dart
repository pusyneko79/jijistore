import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/userProfileModel.dart';

Future<UserProfileModel> getUserDataFromSharedPreferences() async {
  SharedPreferences shared_User = await SharedPreferences.getInstance();
  Map userMap = jsonDecode(shared_User.getString('user') ?? "");
  return UserProfileModel.fromJson(userMap);
}
