import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paypara/core/base/state/utility.dart';
import 'package:paypara/core/constants/navigation_constant.dart';
import 'package:paypara/core/init/navigation/navigation_service.dart';
import 'package:paypara/core/init/theme/color_manager.dart';
import 'package:paypara/core/init/theme/text_style_manager.dart';
import 'package:paypara/models/expense/expense.dart';
import 'package:paypara/models/group/group.dart';
import 'package:paypara/services/expense/expense_service.dart';
import 'package:paypara/ui/widgets/appBar.dart';
import 'package:paypara/ui/widgets/barChart.dart';
import 'package:paypara/ui/widgets/listTile.dart';

class GroupDetailView extends StatefulWidget {
  final GroupDetail group;
  GroupDetailView({this.group});
  @override
  _GroupDetailViewState createState() => _GroupDetailViewState();
}

class _GroupDetailViewState extends State<GroupDetailView> {
  bool loading = false;
  bool expenseDataLoading = false;
  Expense lastExpenseList = new Expense();

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
                  context, NavigationConstants.groupSettingView, widget.group);
            },
            color: Colors.red,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await NavigationService.navigateToPage(
              context, NavigationConstants.newExpenseView, widget.group);
          setState(() {});
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
                  height: Utility.dynamicHeight(0.03),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: Utility.dynamicWidth(0.05),
                    ),
                    Text(
                      "Harcama İstatistikleri",
                      style: TextStyleManager.instance.headline4BlackMedium,
                    ),
                  ],
                ),
                SizedBox(
                  height: Utility.dynamicHeight(0.01),
                ),
                BarChartGroup(),
                Row(
                  children: [
                    SizedBox(
                      width: Utility.dynamicWidth(0.05),
                    ),
                    Text(
                      "Kategoriler",
                      style: TextStyleManager.instance.headline4BlackMedium,
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
                              child: IconButton(
                                onPressed: () =>
                                    {filterByCategory(categories[index]["id"])},
                                icon: Icon(categories[index]["icon"]),
                                color: ColorManager.instance.white,
                                iconSize: Utility.dynamicHeight(0.05),
                              ),
                            ),
                            SizedBox(
                              height: Utility.dynamicHeight(0.01),
                            ),
                            Text(
                              categories[index]["name"],
                              style: TextStyle(
                                fontSize: Utility.dynamicHeight(0.015),
                                fontFamily: TextStyleManager.instance.regular,
                              ),
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
                expenseDataLoading
                    ? Center(child: CircularProgressIndicator())
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: Utility.dynamicWidth(0.05)),
                            child: Text(
                              "Son Harcamalar",
                              style: TextStyleManager
                                  .instance.headline4BlackMedium,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: Utility.dynamicWidth(0.05)),
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
                    itemCount: lastExpenseList.result.length,
                    itemBuilder: (context, index) {
                      return listTileWidget(
                          categoryId: lastExpenseList.result[index].categoryId,
                          subtitle:
                              "${lastExpenseList.result[index].date.day}/${lastExpenseList.result[index].date.month}/${lastExpenseList.result[index].date.year}     (${lastExpenseList.result[index].nameSurname})",
                          price: lastExpenseList.result[index].price,
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
    this.lastExpenseList = await ExpenseService.instance
        .getExpenses(context: context, groupID: widget.group.id);
    setState(() {
      loading = false;
    });
  }

  Future filterByCategory(int categoryId) async {
    setState(() {
      expenseDataLoading = true;
    });
    this.lastExpenseList.result =
        await ExpenseService.instance.getExpensesByCategoryId(categoryId);
    setState(() {
      expenseDataLoading = false;
    });
  }
}
