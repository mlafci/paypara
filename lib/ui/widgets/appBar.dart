import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paypara/core/base/state/utility.dart';
import 'package:paypara/core/init/navigation/navigation_service.dart';
import 'package:paypara/core/init/theme/color_manager.dart';
import 'package:paypara/core/init/theme/text_style_manager.dart';

Widget appBar({BuildContext context, String text, bool isBack, List<Widget> actions}) {
  return AppBar(
      backgroundColor: ColorManager.instance.white,
      automaticallyImplyLeading: false,
      elevation: 1,
      title: Text(
        text,
        style: TextStyleManager.instance.headline4BlackMedium,
      ),
      leading: isBack
          ? IconButton(
              icon: Icon(
                CupertinoIcons.back,
              ),
              color: ColorManager.instance.black,
              splashRadius: Utility.dynamicHeight(0.027),
              iconSize: Utility.dynamicHeight(0.04),
              onPressed: () {
                NavigationService.navigateToPop(context);
              },
            )
          : null,
      actions: actions);
}
