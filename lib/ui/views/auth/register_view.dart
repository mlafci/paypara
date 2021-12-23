import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:paypara/controller/image_picker/image_picker_controller.dart';
import 'package:paypara/core/base/state/utility.dart';
import 'package:paypara/core/constants/asset_constant.dart';
import 'package:paypara/core/constants/navigation_constant.dart';
import 'package:paypara/core/init/navigation/navigation_service.dart';
import 'package:paypara/core/init/theme/color_manager.dart';
import 'package:paypara/core/init/theme/text_style_manager.dart';
import 'package:paypara/services/auth/auth_service.dart';
import 'package:paypara/ui/view_models/image_picker/image_picker_model.dart';
import 'package:paypara/ui/view_models/text_input/text_input_model.dart';
import 'package:paypara/ui/widgets/button.dart';
import 'package:paypara/ui/widgets/textField.dart';

class RegisterView extends StatefulWidget {
  @override
  RegisterViewState createState() => RegisterViewState();
}

class RegisterViewState extends State<RegisterView> {
  TextInputModel email, name, surname, password;
  ImagePickerModel userImage = ImagePickerModel();
  bool loading = false;
  @override
  void initState() {
    email = TextInputModel(
      hintText: "E-posta adresiniz",
      icon: Icon(
        CupertinoIcons.mail,
        color: ColorManager.instance.pink,
      ),
    );
    name = TextInputModel(
      hintText: "Adınız",
      icon: Icon(
        CupertinoIcons.person,
        color: ColorManager.instance.pink,
      ),
    );
    surname = TextInputModel(
      hintText: "Soyadınız",
      icon: Icon(
        CupertinoIcons.person,
        color: ColorManager.instance.pink,
      ),
    );
    password = TextInputModel(
      hintText: "Şifreniz",
      icon: Icon(
        CupertinoIcons.lock,
        color: ColorManager.instance.pink,
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
              Text(
                "PayPara",
                style: TextStyleManager.instance.headline1BlackBold,
              ),
              SizedBox(
                height: Utility.dynamicHeight(0.05),
              ),
              Stack(
                children: [
                  CircleAvatar(
                    radius: Utility.dynamicHeight(0.08),
                    backgroundImage: (userImage.image != null)
                        ? MemoryImage(
                            base64Decode(userImage.image),
                          )
                        : AssetImage(
                            AssetConstant.user,
                          ),
                    backgroundColor: ColorManager.instance.grey,
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: () async {
                        await ImagePickerController.getImageFromGallery(userImage);
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.all(
                          Utility.dynamicHeight(0.005),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorManager.instance.black,
                        ),
                        child: Icon(
                          CupertinoIcons.pencil,
                          color: ColorManager.instance.white,
                          size: Utility.dynamicHeight(0.03),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Utility.dynamicHeight(0.05),
              ),
              textField(textInputModel: email),
              SizedBox(
                height: Utility.dynamicHeight(0.02),
              ),
              textField(textInputModel: name),
              SizedBox(
                height: Utility.dynamicHeight(0.02),
              ),
              textField(textInputModel: surname),
              SizedBox(
                height: Utility.dynamicHeight(0.02),
              ),
              textField(textInputModel: password),
              SizedBox(
                height: Utility.dynamicHeight(0.05),
              ),
              button(
                text: "Kayıt Ol",
                isPrimary: true,
                function: register,
                loading: loading,
              ),
              SizedBox(
                height: Utility.dynamicHeight(0.03),
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: 'Zaten bir hesabın var mı? ',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                      text: 'Giriş Yap',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          NavigationService.navigateToPage(context, NavigationConstants.loginView);
                        }),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future register() async {
    setState(() {
      loading = true;
    });
    if (userImage.image != null) {
      await AuthService.instance.register(context: context, email: email, password: password, name: name, surname: surname, image: userImage.image);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Lütfen Profil Fotoğrafı Seçiniz!",
            style: TextStyleManager.instance.headline5WhiteMedium,
          ),
        ),
      );
    }
    setState(() {
      loading = false;
    });
  }
}
