import 'package:flutter/material.dart';
import 'package:paypara/core/constant/navigation_constant.dart';
import 'package:paypara/view/home/home_view.dart';

class NavigationService {
  static navigateToPage(BuildContext context, String path,
      [Object data]) async {
    var result = await Navigator.pushNamed(
      context,
      path,
      arguments: data,
    );
    return result;
  }

  static navigateToPop(BuildContext context, [Object data]) async {
    await Navigator.pop(
      context,
      data,
    );
  }

  static navigateToPageClear(BuildContext context, String path,
      [Object data]) async {
    await Navigator.pushNamedAndRemoveUntil(
      context,
      path,
      (Route<dynamic> route) => false,
      arguments: data,
    );
  }
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case NavigationConstants.homeView:
      return MaterialPageRoute(builder: (_) => HomeView());
    default:
      return null;
  }
}
