import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paypara/controller/image_picker/image_picker_controller.dart';
import 'package:paypara/core/base/state/utility.dart';
import 'package:paypara/core/constants/asset_constant.dart';
import 'package:paypara/core/init/theme/color_manager.dart';
import 'package:paypara/core/init/theme/text_style_manager.dart';
import 'package:paypara/models/user/user.dart';
import 'package:paypara/services/group/group_service.dart';
import 'package:paypara/services/user/user_service.dart';
import 'package:paypara/ui/view_models/image_picker/image_picker_model.dart';
import 'package:paypara/ui/view_models/text_input/text_input_model.dart';
import 'package:paypara/ui/widgets/button.dart';
import 'package:paypara/ui/widgets/textField.dart';

class GroupSettingView extends StatefulWidget {
  @override
  _GroupSettingViewState createState() => _GroupSettingViewState();
}

class _GroupSettingViewState extends State<GroupSettingView> {
  ImagePickerModel groupImage = ImagePickerModel();
  TextInputModel groupName, userName;
  String currencyTpye = "Dolar";
  int type = 0;
  User groupUser = new User();

  @override
  void initState() {
    groupName = TextInputModel(
      hintText: "Grup Adı",
      icon: Icon(
        CupertinoIcons.mail,
        color: ColorManager.instance.pink,
      ),
    );
    userName = TextInputModel(
      hintText: "Kullanıcı Ara",
      icon: Icon(
        CupertinoIcons.person,
        color: ColorManager.instance.pink,
      ),
      isSearchText: true,
    );
    groupUser.result = [];
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GroupService.instance.addGroup(
            context: context,
            groupName: groupName,
            currencyType: type,
            image: groupImage.image,
            groupUser: groupUser,
          );
        },
        child: Icon(
          CupertinoIcons.checkmark_alt,
        ),
      ),
      body: Container(
        width: Utility.width,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: Utility.dynamicHeight(0.05),
            ),
            Stack(
              children: [
                CircleAvatar(
                  radius: Utility.dynamicHeight(0.08),
                  backgroundImage: (groupImage.image != null)
                      ? MemoryImage(
                          base64Decode(groupImage.image),
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
                      await ImagePickerController.getImageFromGallery(
                          groupImage);
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
            textField(textInputModel: groupName),
            SizedBox(
              height: Utility.dynamicHeight(0.02),
            ),
            Row(
              children: [
                SizedBox(
                  width: Utility.dynamicWidth(0.05),
                ),
                // Text(
                //   "Para Birimi",
                //   style: TextStyleManager.instance.headline5BlackRegular,
                // ),
                // SizedBox(
                //   width: Utility.dynamicWidth(0.15),
                // ),
                // DropdownButton<String>(
                //   value: currencyTpye,
                //   items: <String>['Dolar', 'Euro', 'Türk Lirası'].map((String value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(value),
                //     );
                //   }).toList(),
                //   onChanged: (selectedItem) {
                //     setState(
                //       () {
                //         currencyTpye = selectedItem;
                //         if (selectedItem == "Dolar") {
                //           type = 0;
                //         } else if (selectedItem == "Euro") {
                //           type = 1;
                //         } else {
                //           type = 2;
                //         }
                //       },
                //     );
                //   },
                // ),
              ],
            ),
            SizedBox(
              height: Utility.dynamicHeight(0.02),
            ),
            textField(
              textInputModel: userName,
              function: () async {
                await UserService.instance
                    .searchUser(context: context, userName: userName);
                setState(() {});
              },
            ),
            SizedBox(
              height: Utility.dynamicHeight(0.02),
            ),
            Container(
              height: Utility.dynamicHeight(0.08),
              width: Utility.dynamicWidth(0.9),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: groupUser.result.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      right: Utility.dynamicWidth(0.04),
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: Utility.dynamicHeight(0.025),
                              backgroundImage: MemoryImage(
                                base64Decode(groupUser.result[index].image),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: GestureDetector(
                                onTap: () async {
                                  showCupertinoModalPopup<void>(                                  
                                      context: context,
                                      builder: (BuildContext context) => Container(
                                        child:
                                        CupertinoAlertDialog(
                                            title: const Text('Alert'),                                            
                                            content: Text(
                                                "${groupUser.result[index].name.toUpperCase()}  ${groupUser.result[index].surname.toUpperCase()} kullanıcısını silmek istediğinize emin misiniz ?"),
                                            actions: <CupertinoDialogAction>[
                                              CupertinoDialogAction(
                                                child: const Text('No'),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              CupertinoDialogAction(
                                                child: const Text('Yes'),
                                                isDestructiveAction: true,
                                                onPressed: () {
                                                  setState(() {
                                                     groupUser.result.removeAt(index);
                                                  });
                                                  Navigator.pop(context);
                                                },
                                              )
                                            ],
                                          ),  
                                          ) 
                                        );                                                                  
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.all(
                                    Utility.dynamicHeight(0.005),
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                  child: Icon(
                                    CupertinoIcons.xmark,
                                    color: ColorManager.instance.white,
                                    size: Utility.dynamicHeight(0.012),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Utility.dynamicHeight(0.005),
                        ),
                        Text(
                          "${groupUser.result[index].name}",
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: Utility.dynamicHeight(0.02),
            ),
            (UserService.instance.user.result != null)
                ? Expanded(
                    child: Container(
                      width: Utility.dynamicWidth(0.9),
                      child: ListView.builder(
                        itemCount: UserService.instance.user.result.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: Utility.dynamicHeight(0.02),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                if (!groupUser.result.any((element) =>
                                    element.id ==
                                    UserService
                                        .instance.user.result[index].id)) {                                  
                                  showCupertinoModalPopup<void>(                                  
                                      context: context,
                                      builder: (BuildContext context) => Container(
                                        child:
                                        CupertinoAlertDialog(
                                            title: const Text('Alert'),                                            
                                            content: Text(
                                                "${UserService.instance.user.result[index].name.toUpperCase()}  ${UserService.instance.user.result[index].surname.toUpperCase()} kullanıcısını eklemek istediğinize emin misiniz ?"),
                                            actions: <CupertinoDialogAction>[
                                              CupertinoDialogAction(
                                                child: const Text('No'),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              CupertinoDialogAction(
                                                child: const Text('Yes'),
                                                isDestructiveAction: true,
                                                onPressed: () {
                                                  setState(() {
                                                    groupUser.result.add(
                                                        UserService
                                                            .instance
                                                            .user
                                                            .result[index]);
                                                  });
                                                  Navigator.pop(context);
                                                },
                                              )
                                            ],
                                          ),  
                                          )                                                                             
                                        );                                 
                                }
                              },
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: Utility.dynamicHeight(0.03),
                                      backgroundImage: MemoryImage(
                                        base64Decode(UserService
                                            .instance.user.result[index].image),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Utility.dynamicWidth(0.05),
                                    ),
                                    Text(
                                      "${UserService.instance.user.result[index].name}",
                                      style: TextStyleManager
                                          .instance.headline5BlackRegular,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
