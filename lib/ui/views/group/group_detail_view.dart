import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paypara/core/base/state/utility.dart';
import 'package:paypara/core/constants/navigation_constant.dart';
import 'package:paypara/core/init/navigation/navigation_service.dart';
import 'package:paypara/core/init/theme/color_manager.dart';
import 'package:paypara/core/init/theme/text_style_manager.dart';
import 'package:paypara/models/group/group.dart';
import 'package:paypara/services/expense/expense_service.dart';
import 'package:paypara/services/group/group_service.dart';
import 'package:paypara/ui/widgets/appBar.dart';
import 'package:paypara/ui/widgets/listTile.dart';

class GroupDetailView extends StatefulWidget {
  final GroupDetail group;
  GroupDetailView({this.group});
  @override
  _GroupDetailViewState createState() => _GroupDetailViewState();
}

class _GroupDetailViewState extends State<GroupDetailView> {
  bool loading = false;

  @override
  void initState() {
    getLastExpense();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context: context,
        text: "Ev Arkadaşlarım",
        isBack: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              NavigationService.navigateToPage(
                  context, NavigationConstants.groupSettingView);
            },
            color: Colors.red,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Harcama Ekleme Sayfasına Gidecek.");
        },
        child: Icon(
          CupertinoIcons.add,
        ),
      ),
      body: (loading)
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: <Widget>[
                SizedBox(
                  height: Utility.dynamicHeight(0.1),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: Utility.dynamicWidth(0.05),
                    ),
                    Text(
                      "Kategoriler",
                      style: TextStyleManager.instance.headline2BlackMedium,
                    ),
                  ],
                ),
                SizedBox(
                  height: Utility.dynamicHeight(0.02),
                ),
                Container(
                  height: Utility.dynamicHeight(0.12),
                  child: ListView.builder(
                    padding: EdgeInsets.only(left: Utility.dynamicWidth(0.05)),
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding:
                            EdgeInsets.only(right: Utility.dynamicWidth(0.05)),
                        child: Column(
                          children: [
                            Container(
                              width: Utility.dynamicHeight(0.08),
                              height: Utility.dynamicHeight(0.08),
                              decoration: BoxDecoration(
                                color: categories[index]["color"],
                                borderRadius:
                                    BorderRadius.circular(Utility.borderRadius),
                              ),
                              child: Icon(
                                categories[index]["icon"],
                                color: ColorManager.instance.white,
                                size: Utility.dynamicHeight(0.05),
                              ),
                            ),
                            SizedBox(
                              height: Utility.dynamicHeight(0.01),
                            ),
                            Text(
                              categories[index]["name"],
                              style: TextStyleManager
                                  .instance.headline5BlackRegular,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: Utility.dynamicHeight(0.03),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(left: Utility.dynamicWidth(0.05)),
                      child: Text(
                        "Son Harcamalar",
                        style: TextStyleManager.instance.headline2BlackMedium,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(right: Utility.dynamicWidth(0.05)),
                      child: InkWell(
                        onTap: () {
                          NavigationService.navigateToPage(
                              context,
                              NavigationConstants.recentExpensesView,
                              widget.group);
                        },
                        child: Text(
                          "Tümünü Gör",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Utility.dynamicHeight(0.02),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount:
                        ExpenseService.instance.lastExpenses.result.length,
                    itemBuilder: (context, index) {
                      return listTileWidget(
                          categoryId: ExpenseService
                              .instance.lastExpenses.result[index].categoryId,
                          subtitle:
                              "${ExpenseService.instance.lastExpenses.result[index].date.day}/${ExpenseService.instance.lastExpenses.result[index].date.month}/${ExpenseService.instance.lastExpenses.result[index].date.year}     (${ExpenseService.instance.lastExpenses.result[index].nameSurname})",
                          price: ExpenseService
                              .instance.lastExpenses.result[index].price,
                          currencyType: widget.group.currencyType);
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Future getLastExpense() async {
    setState(() {
      loading = true;
    });
    await ExpenseService.instance
        .getExpenses(context: context, groupID: widget.group.id);
    setState(() {
      loading = false;
    });
  }
}
