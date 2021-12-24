import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paypara/core/base/state/utility.dart';
import 'package:paypara/core/constants/app_constant.dart';
import 'package:paypara/core/constants/navigation_constant.dart';
import 'package:paypara/core/init/navigation/navigation_service.dart';
import 'package:paypara/core/init/theme/color_manager.dart';
import 'package:paypara/core/init/theme/text_style_manager.dart';
import 'package:paypara/services/auth/auth_service.dart';
import 'package:paypara/services/group/group_service.dart';
import 'package:paypara/ui/widgets/appBar.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool loading = false;

  @override
  void initState() {
    getMyGroup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Utility.height = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;
    Utility.width = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
    return Scaffold(
      appBar: appBar(
        text: 'PayPara',
        isBack: false,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              NavigationService.navigateToPage(context, NavigationConstants.profileView);
            },
            color: Colors.red,
            splashRadius: Utility.dynamicHeight(0.027),
            iconSize: Utility.dynamicHeight(0.04),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigationService.navigateToPage(context, NavigationConstants.newGroupView);
        },
        child: Icon(
          CupertinoIcons.add,
        ),
      ),
      body: (loading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                SizedBox(
                  height: Utility.dynamicHeight(0.02),
                ),
                Container(
                  width: Utility.dynamicWidth(0.92),
                  height: Utility.dynamicHeight(0.09),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      Utility.dynamicHeight(0.015),
                    ),
                    color: Color(0xff87bba2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: Utility.dynamicWidth(0.03)),
                            child: CircleAvatar(
                              radius: Utility.dynamicHeight(0.025),
                              backgroundImage: MemoryImage(
                                base64Decode(AuthService.instance.account.result.image),
                              ),
                              backgroundColor: ColorManager.instance.grey,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: Utility.dynamicWidth(0.03)),
                            child: Text(
                              "${AuthService.instance.account.result.name} ${AuthService.instance.account.result.surname}",
                              style: TextStyle(color: Colors.white, fontSize: Utility.dynamicHeight(0.02), fontFamily: TextStyleManager.instance.medium),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: Utility.dynamicWidth(0.03)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Toplam Harcama",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Utility.dynamicHeight(0.02),
                              ),
                            ),
                            Text(
                              "${GroupService.instance.myGroup.result.totalExpense} ₺",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Utility.dynamicHeight(0.02),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Utility.dynamicHeight(0.03),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: Utility.dynamicWidth(0.04),
                    ),
                    Text(
                      "Gruplarım",
                      style: TextStyleManager.instance.headline5BlackMedium,
                    ),
                  ],
                ),
                SizedBox(
                  height: Utility.dynamicHeight(0.02),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: GroupService.instance.myGroup.result.groupDetails.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          NavigationService.navigateToPage(context, NavigationConstants.groupDetailView, GroupService.instance.myGroup.result.groupDetails[index]);
                        },
                        leading: Container(
                          width: Utility.dynamicHeight(0.05),
                          height: Utility.dynamicHeight(0.05),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(Utility.dynamicHeight(0.012)),
                            image: DecorationImage(
                              image: MemoryImage(
                                base64Decode(GroupService.instance.myGroup.result.groupDetails[index].groupImage),
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          GroupService.instance.myGroup.result.groupDetails[index].name,
                          style: TextStyle(
                            fontSize: Utility.dynamicHeight(0.015),
                            fontFamily: TextStyleManager.instance.medium,
                          ),
                        ),
                        trailing: Text(
                          '${GroupService.instance.myGroup.result.groupDetails[index].priceStatus} ${ApplicationConstants.currencyList[GroupService.instance.myGroup.result.groupDetails[index].currencyType]}',
                          style: TextStyle(
                              fontSize: Utility.dynamicHeight(0.015),
                              fontFamily: TextStyleManager.instance.medium,
                              color: (GroupService.instance.myGroup.result.groupDetails[index].priceStatus > 0)
                                  ? Colors.green
                                  : (GroupService.instance.myGroup.result.groupDetails[index].priceStatus == 0)
                                      ? Colors.blue
                                      : Colors.red),
                        ),
                      );
                    },
                  ),
                ),
              ],
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
