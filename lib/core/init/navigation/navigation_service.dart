import 'package:flutter/material.dart';
import 'package:paypara/core/constants/navigation_constant.dart';
import 'package:paypara/ui/views/auth/login_view.dart';
import 'package:paypara/ui/views/auth/register_view.dart';
import 'package:paypara/ui/views/auth/reset_password_view.dart';
import 'package:paypara/ui/views/auth/recent_expenses_view.dart';
import 'package:paypara/ui/views/home/home_view.dart';

class NavigationService {
  static navigateToPage(BuildContext context, String path, [Object data]) async {
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

  static navigateToPageClear(BuildContext context, String path, [Object data]) async {
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
    case NavigationConstants.loginView:
      return MaterialPageRoute(builder: (_) => LoginView());
    case NavigationConstants.registerView:
      return MaterialPageRoute(builder: (_) => RegisterView());
    case NavigationConstants.resetPasswordView:
      return MaterialPageRoute(builder: (_) => ResetPasswordView());
    case NavigationConstants.recentExpensesView:
      return MaterialPageRoute(builder: (_) => RecentExpensesView());
    default:
      return null;
  }
}
