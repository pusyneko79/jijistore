import 'dart:convert';

import 'package:footshop/model/userRegisterModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../helper/string.dart';
import '../model/userProfileModel.dart';

Future<int> createUser(UserRegisterModel userRegisterModel) async {
  final response = await http.post(
    Uri.parse("${baseUrl}/register/"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "name": userRegisterModel.name ?? "",
      "address": userRegisterModel.address ?? "",
      "age": userRegisterModel.age.toString(),
      "img": "https://cdn-icons-png.flaticon.com/512/147/147133.png",
      "email": userRegisterModel.email ?? "",
      "password": userRegisterModel.password ?? "",
      "phone": userRegisterModel.phone ?? "0"
    }),
  );
  print(response.body);
  if (response.statusCode == 200) {
    return 200;
  } else {
    return 400;
  }
}

Future<int> updateUser(UserRegisterModel userRegisterModel) async {
  final response = await http.put(
    Uri.parse("${baseUrl}/register/"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      ""
          "name": userRegisterModel.name ?? "",
      "address": userRegisterModel.address ?? "",
      "age": userRegisterModel.age.toString(),
      "img": "https://cdn-icons-png.flaticon.com/512/147/147133.png",
      "email": userRegisterModel.email ?? "",
      "password": userRegisterModel.password ?? "",
      "phone": userRegisterModel.phone ?? "0"
    }),
  );
  print(response.body);
  if (response.statusCode == 200) {
    return 200;
  } else {
    return 400;
  }
}

Future<dynamic> login(String email, String password) async {
  final response = await http.post(
    Uri.parse("${baseUrl}/login/"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{"email": email, "password": password}),
  );
  print(response.body);
  if (response.statusCode == 200) {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var _ = await prefs.setString('user', response.body);
    return "";
  } else {
    return response.body;
  }
}
