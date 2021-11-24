import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paypara/core/constant/app_constant.dart';
import 'package:paypara/core/constant/navigation_constant.dart';
import 'package:paypara/core/init/navigation/navigation_service.dart';
import 'package:paypara/core/init/theme/app_theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      initialRoute: NavigationConstants.homeView,
      onGenerateRoute: generateRoute,
    ),
  );
}
