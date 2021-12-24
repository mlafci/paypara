import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paypara/controller/image_picker/image_picker_controller.dart';
import 'package:paypara/core/base/state/utility.dart';
import 'package:paypara/core/constants/asset_constant.dart';
import 'package:paypara/core/constants/navigation_constant.dart';
import 'package:paypara/core/init/navigation/navigation_service.dart';
import 'package:paypara/core/init/theme/color_manager.dart';
import 'package:paypara/core/init/theme/text_style_manager.dart';
import 'package:paypara/services/auth/auth_service.dart';
import 'package:paypara/services/group/group_service.dart';
import 'package:paypara/ui/view_models/image_picker/image_picker_model.dart';
import 'package:paypara/ui/view_models/text_input/text_input_model.dart';
import 'package:paypara/ui/widgets/appBar.dart';
import 'package:paypara/ui/widgets/button.dart';
import 'package:paypara/ui/widgets/textField.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool loading = false;
  ImagePickerModel userImage = ImagePickerModel();
  TextInputModel name, surname;

  @override
  void initState() {
    name = TextInputModel(
      hintText: "Adınız",
      icon: Icon(
        CupertinoIcons.person,
        color: Colors.grey[800],
      ),
    );
    surname = TextInputModel(
      hintText: "Soyadınız",
      icon: Icon(
        CupertinoIcons.person,
        color: Colors.grey[800],
      ),
    );
    setState(() {
      name.controller.text = AuthService.instance.account.result.name;
      surname.controller.text = AuthService.instance.account.result.surname;
      userImage.image = AuthService.instance.account.result.image;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(
        text: 'PROFİL',
        isBack: true,
        context: context,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            iconSize: Utility.dynamicHeight(0.04),
            color: Colors.red,
            onPressed: () {
              AuthService.instance.logOut(context);
            },
          )
        ],
      ),
      body: Container(
        width: Utility.width,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: Utility.dynamicHeight(0.02),
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
                height: Utility.dynamicHeight(0.04),
              ),
              textField(textInputModel: name),
              SizedBox(
                height: Utility.dynamicHeight(0.03),
              ),
              textField(textInputModel: surname),
              SizedBox(
                height: Utility.dynamicHeight(0.03),
              ),
              button(
                loading: loading,
                function: updateProfile,
                text: "Profili Güncelle",
                isPrimary: true,
              ),
              SizedBox(
                height: Utility.dynamicHeight(0.02),
              ),
              InkWell(
                child: Text(
                  'Şifre Değiştir',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                onTap: () {
                  NavigationService.navigateToPage(context, NavigationConstants.changePasswordView);
                },
              ),
              SizedBox(
                height: Utility.dynamicHeight(0.02),
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
              for (int index = 0; index < GroupService.instance.myGroup.result.groupDetails.length; index++)
                Card(
                  child: ListTile(
                    onTap: () {
                      NavigationService.navigateToPage(context, NavigationConstants.groupDetailView, GroupService.instance.myGroup.result.groupDetails[index]);
                    },
                    leading: CircleAvatar(
                      backgroundImage: MemoryImage(base64Decode(GroupService.instance.myGroup.result.groupDetails[index].groupImage)),
                    ),
                    title: Text(
                      GroupService.instance.myGroup.result.groupDetails[index].name,
                    ),
                    trailing: IconButton(
                      icon: Icon(CupertinoIcons.xmark_circle_fill),
                      iconSize: Utility.dynamicHeight(0.04),
                      color: Colors.red,
                      onPressed: () {
                        leaveGroup(index);
                      },
                    ),
                  ),
                ),
              SizedBox(
                height: Utility.dynamicHeight(0.02),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future updateProfile() async {
    setState(() {
      loading = true;
    });
    await AuthService.instance.updateProfile(context: context, name: name, surname: surname, image: userImage.image);
    setState(() {
      loading = false;
    });
  }

  Future leaveGroup(int index) async {
    setState(() {
      loading = true;
    });
    await GroupService.instance.deleteGroupFromUser(context: context, groupId: GroupService.instance.myGroup.result.groupDetails[index].id);
    setState(() {
      loading = false;
    });
  }
}
