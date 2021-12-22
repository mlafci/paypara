import 'package:flutter/material.dart';
import 'package:paypara/core/init/network/network_manager.dart';
import 'package:paypara/models/user/user.dart';
import 'package:paypara/ui/view_models/text_input/text_input_model.dart';

class UserService {
  static UserService _instance;
  static UserService get instance {
    if (_instance == null) _instance = UserService._init();
    return _instance;
  }

  UserService._init();

  User user = new User();

  Future profileStatus({
    BuildContext context,
    int netStatus,
    int payable,
    int receivable,
  }) async {
    dynamic model = {
      "netStatus": netStatus,
      "payable": payable,
      "receivable": receivable,
    };
    await NetworkManager.instance.profileStatus(data: model);
  }

  Future searchUser({
    BuildContext context,
    TextInputModel userName,
  }) async {
    user = await NetworkManager.instance
        .getSearchUser(data: userName.controller.text);
  }
}
