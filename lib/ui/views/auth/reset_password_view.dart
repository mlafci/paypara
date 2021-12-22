import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:paypara/core/base/state/utility.dart';
import 'package:paypara/core/constants/navigation_constant.dart';
import 'package:paypara/core/init/navigation/navigation_service.dart';
import 'package:paypara/core/init/theme/color_manager.dart';
import 'package:paypara/core/init/theme/text_style_manager.dart';
import 'package:paypara/services/auth/auth_service.dart';
import 'package:paypara/ui/view_models/text_input/text_input_model.dart';
import 'package:paypara/ui/widgets/appBar.dart';
import 'package:paypara/ui/widgets/button.dart';
import 'package:paypara/ui/widgets/textField.dart';

class ResetPasswordView extends StatefulWidget {
  @override
  ResetPasswordViewState createState() => ResetPasswordViewState();
}

class ResetPasswordViewState extends State<ResetPasswordView> {
  TextInputModel currentPassword, newPassword1, newPassword2;
  @override
  void initState() {
    currentPassword = TextInputModel(
      hintText: "Eski şifreniz",
      icon: Icon(
        CupertinoIcons.lock,
        color: ColorManager.instance.pink,
      ),
    );
    newPassword1 = TextInputModel(
      hintText: "Yeni şifreniz",
      icon: Icon(
        CupertinoIcons.lock,
        color: ColorManager.instance.pink,
      ),
    );
    newPassword2 = TextInputModel(
      hintText: "Yeni şifrenizi doğrulayın",
      icon: Icon(
        CupertinoIcons.lock,
        color: ColorManager.instance.pink,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Utility.height =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;
    Utility.width =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
    return Scaffold(
      appBar: appBar(
        text: 'ŞİFRE SIFIRLAMA',
        isBack: true,
        context: context,
      ),
      body: Container(
        width: Utility.width,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: Utility.dynamicHeight(0.10),
            ),
            Text(
              "Yeni şifreniz eski şifrenizden farklı olmalıdır",
              style: TextStyleManager.instance.headline5BlackRegular,
            ),
            SizedBox(
              height: Utility.dynamicHeight(0.05),
            ),
            textField(textInputModel: currentPassword),
            SizedBox(
              height: Utility.dynamicHeight(0.03),
            ),
            textField(textInputModel: newPassword1),
            SizedBox(
              height: Utility.dynamicHeight(0.03),
            ),
            textField(textInputModel: newPassword2),
            SizedBox(
              height: Utility.dynamicHeight(0.05),
            ),
            button(
              text: "Şifremi değiştir",
              isPrimary: true,
              function: () {
                NavigationService.navigateToPage(
                    context, NavigationConstants.loginView);
              },
            ),
            SizedBox(
              height: Utility.dynamicHeight(0.03),
            ),
          ],
        ),
      ),
    );
  }
}