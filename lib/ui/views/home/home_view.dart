import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paypara/core/base/state/utility.dart';
import 'package:paypara/core/constants/app_constant.dart';
import 'package:paypara/core/constants/navigation_constant.dart';
import 'package:paypara/core/init/navigation/navigation_service.dart';
import 'package:paypara/core/init/theme/color_manager.dart';
import 'package:paypara/core/init/theme/text_style_manager.dart';
import 'package:paypara/models/account/account.dart';
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
    Utility.height =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;
    Utility.width =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
    return Scaffold(
      appBar: appBar(
        text: 'PayPara',
        isBack: false,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            iconSize: Utility.dynamicHeight(0.04),
            color: Colors.grey,
            onPressed: () => {
              NavigationService.navigateToPage(
                  context, NavigationConstants.profileView)
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NavigationService.navigateToPage(
              context, NavigationConstants.newGroupView);
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
                  width: Utility.dynamicWidth(0.9),
                  height: Utility.dynamicHeight(0.08),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Utility.borderRadius),
                      color: Colors.blue),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: Utility.dynamicWidth(0.05)),
                            child: CircleAvatar(
                              radius: Utility.dynamicHeight(0.03),
                              backgroundImage: MemoryImage(
                                base64Decode(
                                    AuthService.instance.account.result.image),
                              ),
                              backgroundColor: ColorManager.instance.grey,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: Utility.dynamicWidth(0.03)),
                            child: Text(
                              "${AuthService.instance.account.result.name}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Utility.dynamicHeight(0.025),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(right: Utility.dynamicWidth(0.05)),
                        child: Text(
                          "${GroupService.instance.myGroup.result.totalExpense} ₺",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Utility.dynamicHeight(0.02),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Utility.dynamicHeight(0.05),
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
                    itemCount: GroupService
                        .instance.myGroup.result.groupDetails.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          onTap: () {
                            NavigationService.navigateToPage(
                                context,
                                NavigationConstants.groupDetailView,
                                GroupService.instance.myGroup.result
                                    .groupDetails[index]);
                          },
                          leading: CircleAvatar(
                            backgroundImage: MemoryImage(base64Decode(
                                GroupService.instance.myGroup.result
                                    .groupDetails[index].groupImage)),
                          ),
                          title: Text(
                            GroupService.instance.myGroup.result
                                .groupDetails[index].name,
                          ),
                          trailing: Text(
                            '${GroupService.instance.myGroup.result.groupDetails[index].priceStatus} ${ApplicationConstants.currencyList[GroupService.instance.myGroup.result.groupDetails[index].currencyType]}',
                            style: TextStyle(
                                fontFamily: TextStyleManager.instance.medium,
                                color: (GroupService.instance.myGroup.result
                                            .groupDetails[index].priceStatus >
                                        0)
                                    ? Colors.green
                                    : (GroupService
                                                .instance
                                                .myGroup
                                                .result
                                                .groupDetails[index]
                                                .priceStatus ==
                                            0)
                                        ? Colors.blue
                                        : Colors.red),
                          ),
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
