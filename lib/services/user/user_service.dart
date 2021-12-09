import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:paypara/core/init/theme/text_style_manager.dart';
import 'package:paypara/models/user/user.dart';
import 'package:paypara/services/network/network_manager.dart';
import 'package:paypara/ui/view_models/text_input/text_input_model.dart';

class UserService {
  static UserService _instance;
  static UserService get instance {
    if (_instance == null) _instance = UserService._init();
    return _instance;
  }

  UserService._init();

  User user = new User();

  Future searchUser({
    BuildContext context,
    TextInputModel userName,
  }) async {
    Response response = await NetworkManager.instance.searchUser(userName.controller.text);
    if (response.statusCode == 200) {
      user = User.fromJson(jsonDecode(response.body));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "${jsonDecode(response.body)["error"]["message"]}",
            style: TextStyleManager.instance.headline5WhiteMedium,
          ),
        ),
      );
    }
  }
}
