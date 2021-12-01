import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paypara/core/base/state/utility.dart';
import 'package:paypara/core/init/theme/color_manager.dart';
import 'package:paypara/core/init/theme/text_style_manager.dart';
import 'package:paypara/services/auth/auth_service.dart';
import 'package:paypara/ui/view_models/text_input/text_input_model.dart';
import 'package:paypara/ui/widgets/button.dart';
import 'package:paypara/ui/widgets/textField.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextInputModel email, password;
  @override
  void initState() {
    email = TextInputModel(
      hintText: "E-posta adresiniz",
      icon: Icon(
        CupertinoIcons.mail,
        color: ColorManager.instance.pink,
      ),
    );
    password = TextInputModel(
      hintText: "Şifreniz",
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
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: ColorManager.instance.white,
        elevation: 0,
      ),
      body: Container(
        width: Utility.width,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: Utility.dynamicHeight(0.05),
            ),
            Text(
              "PayPara",
              style: TextStyleManager.instance.headline1BlackBold,
            ),
            SizedBox(
              height: Utility.dynamicHeight(0.15),
            ),
            textField(textInputModel: email),
            SizedBox(
              height: Utility.dynamicHeight(0.02),
            ),
            textField(textInputModel: password),
            SizedBox(
              height: Utility.dynamicHeight(0.05),
            ),
            button(
              text: "Giriş Yap",
              isPrimary: true,
              function: () {
                AuthService.instance.login(
                  context: context,
                  email: email,
                  password: password,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
