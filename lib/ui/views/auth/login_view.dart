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
import 'package:paypara/ui/widgets/button.dart';
import 'package:paypara/ui/widgets/textField.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextInputModel email, password;
  bool loading = false;
  @override
  void initState() {
    email = TextInputModel(
      hintText: "E-posta adresiniz",
      icon: Icon(
        CupertinoIcons.mail,
        color: Colors.grey[800],
      ),
    );
    password = TextInputModel(
      hintText: "Şifreniz",
      icon: Icon(
        CupertinoIcons.lock,
        color: Colors.grey[800],
      ),
      obsecureText: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Utility.height = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;
    Utility.width = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: ColorManager.instance.white,
        elevation: 0,
      ),
      body: Container(
        width: Utility.width,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: Utility.dynamicHeight(0.05),
              ),
              Row(
                children: [
                  SizedBox(
                    width: Utility.dynamicWidth(0.05),
                  ),
                  Image.asset("assets/readme/paypara-logo.png", height: Utility.dynamicHeight(0.06)),
                  SizedBox(
                    width: Utility.dynamicWidth(0.05),
                  ),
                  Text(
                    "PayPara",
                    style: TextStyleManager.instance.headline1BlackBold,
                  ),
                ],
              ),
              SizedBox(
                height: Utility.dynamicHeight(0.02),
              ),
              Row(
                children: [
                  SizedBox(
                    width: Utility.dynamicWidth(0.05),
                  ),
                  Container(
                    width: Utility.dynamicWidth(0.8),
                    child: Text(
                      "Paranızı nereye harcadığınızı öğrenmek istiyorsanız doğru yerdesiniz.",
                      style: TextStyleManager.instance.headline5BlackRegular,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Utility.dynamicHeight(0.1),
              ),
              textField(textInputModel: email),
              SizedBox(
                height: Utility.dynamicHeight(0.02),
              ),
              textField(textInputModel: password),
              SizedBox(
                height: Utility.dynamicHeight(0.35),
              ),
              button(text: "Giriş Yap", isPrimary: true, function: login, loading: loading),
              SizedBox(
                height: Utility.dynamicHeight(0.02),
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: 'Üye Değil Misiniz? ',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                      text: 'Üye Ol',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          NavigationService.navigateToPage(context, NavigationConstants.registerView);
                        }),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future login() async {
    setState(() {
      loading = true;
    });
    await AuthService.instance.login(context: context, email: email, password: password);
    setState(() {
      loading = false;
    });
  }
}
