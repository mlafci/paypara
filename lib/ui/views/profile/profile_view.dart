import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paypara/controller/image_picker/image_picker_controller.dart';
import 'package:paypara/core/base/state/utility.dart';
import 'package:paypara/core/constants/asset_constant.dart';
import 'package:paypara/core/init/theme/color_manager.dart';
import 'package:paypara/models/user/user.dart';
import 'package:paypara/ui/view_models/image_picker/image_picker_model.dart';
import 'package:paypara/ui/widgets/appBar.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  ImagePickerModel userImage = ImagePickerModel();
  int type = 0;
  User userProfile = new User();
  @override
  Widget build(BuildContext context) {
    Utility.height =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;
    Utility.width =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(
        text: 'PROFIL',
        isBack: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("kayıt edilecek");
        },
        child: Icon(
          CupertinoIcons.floppy_disk,
        ),
      ),
      body: Container(
        width: Utility.width,
        child: Column(children: <Widget>[
          SizedBox(
            height: Utility.dynamicHeight(0.05),
          ),
          Stack(
            children: [
              CircleAvatar(
                radius: Utility.dynamicHeight(0.07),
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
            height: Utility.dynamicHeight(0.02),
          ),
          Text("anıl"
              //"${userProfile.result[index].name.toUpperCase()} ${userProfile.result[index].surname.toUpperCase()}",
              )
        ]),
      ),
    );
  }
}
