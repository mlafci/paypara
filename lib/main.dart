import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:paypara/core/constants/app_constant.dart';
import 'package:paypara/core/constants/navigation_constant.dart';
import 'package:paypara/core/init/navigation/navigation_service.dart';
import 'package:paypara/core/init/theme/app_theme.dart';
import 'package:paypara/services/auth/auth_service.dart';

import 'core/init/locale_manager.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocaleManager.preferencesInit();
  bool isLogin = AuthService.instance.isLogin();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(
    MaterialApp(
      theme: AppTheme.instance.theme,
      debugShowCheckedModeBanner: false,
      title: ApplicationConstants.appName,
      initialRoute: isLogin
          ? NavigationConstants.homeView
          : NavigationConstants.loginView,
      locale: Locale("tr", "TR"),
      supportedLocales: [Locale("tr", "TR")],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      onGenerateRoute: generateRoute,
    ),
  );
}
