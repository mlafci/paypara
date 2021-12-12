import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paypara/core/base/state/utility.dart';
import 'package:paypara/core/constants/navigation_constant.dart';
import 'package:paypara/core/init/navigation/navigation_service.dart';
import 'package:paypara/core/init/theme/text_style_manager.dart';
import 'package:paypara/ui/widgets/button.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    Utility.height = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;
    Utility.width = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigationService.navigateToPage(context, NavigationConstants.newGroupView);
        },
        child: Icon(
          CupertinoIcons.add,
        ),
      ),
      body: Center(
        child: button(
          function: () {
            NavigationService.navigateToPage(context, NavigationConstants.groupDetailView);
          },
          isPrimary: true,
          text: "Group",
        ),
      ),
    );
  }
}
