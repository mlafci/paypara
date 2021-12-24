import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:paypara/core/constants/enums/preferences_keys_enum.dart';
import 'package:paypara/core/constants/navigation_constant.dart';
import 'package:paypara/core/init/locale_manager.dart';
import 'package:paypara/core/init/navigation/navigation_service.dart';
import 'package:paypara/core/init/network/network_manager.dart';
import 'package:paypara/core/init/theme/text_style_manager.dart';
import 'package:paypara/models/account/account.dart';
import 'package:paypara/ui/view_models/text_input/text_input_model.dart';

class AuthService {
  static AuthService _instance;
  static AuthService get instance {
    if (_instance == null) _instance = AuthService._init();
    return _instance;
  }

  AuthService._init();

  Account account = new Account();

  Future login({
    BuildContext context,
    TextInputModel email,
    TextInputModel password,
  }) async {
    dynamic model = {
      "email": email.controller.text,
      "password": password.controller.text,
    };
    Response response = await NetworkManager.instance.login(model);
    if (response.statusCode == 200) {
      account = Account.fromJson(jsonDecode(response.body));
      await saveUser();
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
    }
  }

  Future register({
    BuildContext context,
    TextInputModel email,
    TextInputModel password,
    TextInputModel name,
    TextInputModel surname,
    String image,
  }) async {
    dynamic model = {
      "email": email.controller.text,
      "password": password.controller.text,
      "phoneNumber": null,
      "name": name.controller.text,
      "surname": surname.controller.text,
      "image": image,
    };
    Response response = await NetworkManager.instance.register(model);
    if (response.statusCode == 200) {
      account = Account.fromJson(jsonDecode(response.body));
      await saveUser();
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
    }
  }

  Future updateProfile({
    BuildContext context,
    TextInputModel name,
    TextInputModel surname,
    String image,
  }) async {
    dynamic model = {
      "userId": account.result.userId,
      "name": name.controller.text,
      "surname": surname.controller.text,
      "image": image,
    };
    Response response = await NetworkManager.instance.updateProfile(model);
    if (response.statusCode == 200) {
      account = Account.fromJson(jsonDecode(response.body));
      await saveUser();
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
    }
  }

  bool isLogin() {
    dynamic json = {
      "result": {
        "userId": LocaleManager.instance.getString(PreferencesKeys.USERID),
        "name": LocaleManager.instance.getString(PreferencesKeys.NAME),
        "surname": LocaleManager.instance.getString(PreferencesKeys.SURNAME),
        "image": LocaleManager.instance.getString(PreferencesKeys.IMAGE),
      },
    };
    if (LocaleManager.instance.getString(PreferencesKeys.USERID) != "") {
      account = Account.fromJson(json);
      return true;
    } else {
      return false;
    }
  }

  Future saveUser() async {
    await LocaleManager.instance.setString(PreferencesKeys.USERID, account.result.userId);
    await LocaleManager.instance.setString(PreferencesKeys.NAME, account.result.name);
    await LocaleManager.instance.setString(PreferencesKeys.SURNAME, account.result.surname);
    await LocaleManager.instance.setString(PreferencesKeys.IMAGE, account.result.image);
  }

  Future logOut(BuildContext context) async {
    await LocaleManager.instance.removeAllSharedPreferences();
    NavigationService.navigateToPageClear(context, NavigationConstants.loginView);
  }
}
