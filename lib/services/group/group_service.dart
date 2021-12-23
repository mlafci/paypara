import 'package:flutter/material.dart';
import 'package:paypara/core/constants/navigation_constant.dart';
import 'package:paypara/core/init/navigation/navigation_service.dart';
import 'package:paypara/core/init/network/network_manager.dart';
import 'package:paypara/core/init/theme/text_style_manager.dart';
import 'package:paypara/models/group/group.dart';
import 'package:paypara/models/user/user.dart';
import 'package:paypara/services/auth/auth_service.dart';
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
      "adminUserId": AuthService.instance.account.result.userId,
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
        .getGroup(data: AuthService.instance.account.result.userId);
  }

  Future<User> getGroupUsers({BuildContext context, int groupId}) async {
    var result = await NetworkManager.instance.getGroupUsers(data: groupId);
    return result;
  }

  Future deleteGroupFromUser({BuildContext context, int groupId}) async {
    dynamic model = {
      "GroupId": groupId,
      "UserId": AuthService.instance.account.result.userId,
      "IsAdmin": true,
      "IsActive": true,
    };
    var result = await NetworkManager.instance.deleteGroupFromUser(data: model);
    if (result.isSuccessful) {
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

  Future deleteUserFromGroup(
      {BuildContext context, int groupId, String userId}) async {
    dynamic model = {
      "GroupId": groupId,
      "UserId": userId,
      "IsAdmin": true,
      "IsActive": true,
    };
    var result = await NetworkManager.instance.deleteGroupFromUser(data: model);
    if (result.isSuccessful) {
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
}
