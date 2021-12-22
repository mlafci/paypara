import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:paypara/core/constants/navigation_constant.dart';
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
    /*dynamic model = {
      "email": email.controller.text,
      "password": password.controller.text,
    };*/
    dynamic model = {
      "email": "efefehmitayci@gmail.com",
      "password": "Pp220799",
    };
    Response response = await NetworkManager.instance.login(model);
    if (response.statusCode == 200) {
      account = Account.fromJson(jsonDecode(response.body));
      print("Account");
      print(account.result.surname);
      NavigationService.navigateToPageClear(
          context, NavigationConstants.homeView, account);
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
      "name": name,
      "surname": surname,
      "image": image,
    };
    Response response = await NetworkManager.instance.register(model);
    if (response.statusCode == 200) {
      account = Account.fromJson(jsonDecode(response.body));
      NavigationService.navigateToPage(context, NavigationConstants.loginView);
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