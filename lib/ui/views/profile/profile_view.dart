import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:paypara/controller/image_picker/image_picker_controller.dart';
import 'package:paypara/core/base/state/utility.dart';
import 'package:paypara/core/constants/app_constant.dart';
import 'package:paypara/core/constants/asset_constant.dart';
import 'package:paypara/core/constants/navigation_constant.dart';
import 'package:paypara/core/init/navigation/navigation_service.dart';
import 'package:paypara/core/init/network/network_manager.dart';
import 'package:paypara/core/init/theme/color_manager.dart';
import 'package:paypara/core/init/theme/text_style_manager.dart';
import 'package:paypara/models/account/account.dart';
import 'package:paypara/models/user/user.dart';
import 'package:paypara/services/auth/auth_service.dart';
import 'package:paypara/services/group/group_service.dart';
import 'package:paypara/services/user/user_service.dart';
import 'package:paypara/ui/view_models/image_picker/image_picker_model.dart';
import 'package:paypara/ui/view_models/text_input/text_input_model.dart';
import 'package:paypara/ui/widgets/appBar.dart';
import 'package:paypara/ui/widgets/textField.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool loading = false;
  @override
  void initState() {
    getMyGroup();
    super.initState();
  }

  ImagePickerModel userImage = ImagePickerModel();
  User profileUser = new User();
  int type = 0;
  TextInputModel userName;
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
        context: context,
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
            height: Utility.dynamicHeight(0.05),
          ),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: 'Şifre Değiştir',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      NavigationService.navigateToPage(
                          context, NavigationConstants.resetPasswordView);
                    }),
            ]),
          ),
          SizedBox(
            height: Utility.dynamicHeight(0.1),
          ),
          Row(
            children: [
              SizedBox(
                width: Utility.dynamicWidth(0.05),
              ),
              Text(
                "Gruplarım",
                style: TextStyleManager.instance.headline2BlackMedium,
              ),
            ],
          ),
          SizedBox(
            height: Utility.dynamicHeight(0.02),
          ),
          Expanded(
            child: ListView.builder(
              itemCount:
                  GroupService.instance.myGroup.result.groupDetails.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      NavigationService.navigateToPage(
                          context,
                          NavigationConstants.groupDetailView,
                          GroupService
                              .instance.myGroup.result.groupDetails[index]);
                    },
                    leading: CircleAvatar(
                      backgroundImage: MemoryImage(base64Decode(GroupService
                          .instance
                          .myGroup
                          .result
                          .groupDetails[index]
                          .groupImage)),
                    ),
                    title: Text(
                      GroupService
                          .instance.myGroup.result.groupDetails[index].name,
                    ),
                    trailing: IconButton(
                      icon: Icon(CupertinoIcons.xmark_circle_fill),
                      iconSize: Utility.dynamicHeight(0.04),
                      color: Colors.red,
                      onPressed: () => {
                        GroupService.instance.deleteGroupFromUser(
                            context: context,
                            groupId: GroupService
                                .instance.myGroup.result.groupDetails[index].id)
                      },
                    ),
                  ),
                );
              },
            ),
          )
        ]),
      ),
    );
  }

  Future getMyGroup() async {
    setState(() {
      loading = true;
    });
    await GroupService.instance.getGroup();
    setState(() {
      loading = false;
    });
  }
}
