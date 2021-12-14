import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:paypara/core/constants/navigation_constant.dart';
import 'package:paypara/core/init/navigation/navigation_service.dart';
import 'package:paypara/core/init/network/network_manager.dart';
import 'package:paypara/core/init/theme/text_style_manager.dart';
import 'package:paypara/models/group/group.dart';
import 'package:paypara/models/user/user.dart';
import 'package:paypara/ui/view_models/text_input/text_input_model.dart';

class GroupService {
  static GroupService _instance;
  static GroupService get instance {
    if (_instance == null) _instance = GroupService._init();
    return _instance;
  }

  GroupService._init();

  Group myGroup = new Group();
  Future addGroup({
    BuildContext context,
    TextInputModel groupName,
    int currencyType,
    String image,
    User groupUser,
  }) async {
    List<String> groupUsers = [];
    groupUser.result.forEach((user) {
      groupUsers.add(user.id);
    });
    dynamic model = {
      "name": groupName.controller.text,
      "currencyType": currencyType,
      "image": image,
      "users": groupUsers,
      "adminUserId": "034cdf65-25d9-4218-9881-08011c81de01", // TODO
      "isActive": true,
    };
    myGroup = await NetworkManager.instance.addGroup(data: model);
    if (myGroup.isSuccessful) {
      NavigationService.navigateToPageClear(
          context, NavigationConstants.homeView);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Bir hata oluştu!",
            style: TextStyleManager.instance.headline5WhiteMedium,
          ),
        ),
      );
    }
  }

  Future getGroup({
    BuildContext context,
  }) async {
    myGroup = await NetworkManager.instance
        .getGroup(data: "034cdf65-25d9-4218-9881-08011c81de01");
    /*Response response = await NetworkManager.instance.addGroup(model);
    print(response.body);
    if (response.statusCode == 200) {
      print("Added");
      NavigationService.navigateToPageClear(context, NavigationConstants.homeView);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "${jsonDecode(response.body)["error"]["message"]}",
            style: TextStyleManager.instance.headline5WhiteMedium,
          ),
        ),
      );
    }*/
  }
}