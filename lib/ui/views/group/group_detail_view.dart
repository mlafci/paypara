import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paypara/core/base/state/utility.dart';
import 'package:paypara/core/constants/navigation_constant.dart';
import 'package:paypara/core/init/navigation/navigation_service.dart';
import 'package:paypara/core/init/theme/color_manager.dart';
import 'package:paypara/core/init/theme/text_style_manager.dart';
import 'package:paypara/models/group/group.dart';
import 'package:paypara/services/expense/expense_service.dart';
import 'package:paypara/ui/widgets/appBar.dart';
import 'package:paypara/ui/widgets/barChart.dart';
import 'package:paypara/ui/widgets/listTile.dart';
import 'package:paypara/models/expense/expense.dart' as Expense;

class GroupDetailView extends StatefulWidget {
  final GroupDetail group;
  GroupDetailView({this.group});
  @override
  _GroupDetailViewState createState() => _GroupDetailViewState();
}

class _GroupDetailViewState extends State<GroupDetailView> {
  bool loading = false;
  dynamic lastExpenseList;
  int categoryIndex = -1;

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
        text: widget.group.name,
        isBack: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              NavigationService.navigateToPage(context, NavigationConstants.groupSettingView, widget.group);
            },
            color: Colors.red,
            splashRadius: Utility.dynamicHeight(0.027),
            iconSize: Utility.dynamicHeight(0.04),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await NavigationService.navigateToPage(context, NavigationConstants.newExpenseView, widget.group);
          setState(() {
            lastExpenseList = ExpenseService.instance.expense.result;
          });
        },
        child: Icon(
          CupertinoIcons.add,
        ),
      ),
      body: (loading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: Utility.dynamicHeight(0.03),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: Utility.dynamicWidth(0.04),
                      ),
                      Text(
                        "Harcama İstatistikleri",
                        style: TextStyleManager.instance.headline5BlackMedium,
                      ),
                      SizedBox(
                        width: Utility.dynamicWidth(0.15),
                      ),
                      Container(
                        height: Utility.dynamicHeight(0.01),
                        width: Utility.dynamicHeight(0.01),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorManager.instance.pink,
                        ),
                      ),
                      SizedBox(
                        width: Utility.dynamicWidth(0.01),
                      ),
                      Text("Harcama"),
                      SizedBox(
                        width: Utility.dynamicWidth(0.04),
                      ),
                      Container(
                        height: Utility.dynamicHeight(0.01),
                        width: Utility.dynamicHeight(0.01),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorManager.instance.blue,
                        ),
                      ),
                      SizedBox(
                        width: Utility.dynamicWidth(0.01),
                      ),
                      Text("Kazanç"),
                    ],
                  ),
                  SizedBox(
                    height: Utility.dynamicHeight(0.02),
                  ),
                  BarChartGroup(),
                  SizedBox(
                    height: Utility.dynamicHeight(0.02),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: Utility.dynamicWidth(0.04),
                      ),
                      Text(
                        "Kategoriler",
                        style: TextStyleManager.instance.headline5BlackMedium,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Utility.dynamicHeight(0.02),
                  ),
                  Container(
                    height: Utility.dynamicHeight(0.11),
                    child: ListView.builder(
                      padding: EdgeInsets.only(left: Utility.dynamicWidth(0.05)),
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(right: Utility.dynamicWidth(0.05)),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (categoryIndex != index) {
                                  filterByCategory(categories[index]["id"]);
                                  categoryIndex = index;
                                } else {
                                  lastExpenseList = ExpenseService.instance.expense.result;
                                  categoryIndex = -1;
                                }
                              });
                            },
                            child: Column(
                              children: [
                                Container(
                                  width: Utility.dynamicHeight(0.075),
                                  height: Utility.dynamicHeight(0.075),
                                  decoration: BoxDecoration(
                                    color: categoryIndex == index ? ColorManager.instance.white : categories[index]["color"],
                                    borderRadius: BorderRadius.circular(Utility.dynamicHeight(0.018)),
                                    border: Border.all(
                                      color: categoryIndex == index ? categories[index]["color"] : ColorManager.instance.white,
                                      width: 2,
                                    ),
                                  ),
                                  child: Icon(
                                    categories[index]["icon"],
                                    color: categoryIndex == index ? categories[index]["color"] : ColorManager.instance.white,
                                    size: Utility.dynamicHeight(0.04),
                                  ),
                                ),
                                SizedBox(
                                  height: Utility.dynamicHeight(0.005),
                                ),
                                Text(
                                  categories[index]["name"],
                                  style: TextStyle(
                                    fontSize: Utility.dynamicHeight(0.013),
                                    fontFamily: TextStyleManager.instance.medium,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: Utility.dynamicHeight(0.01),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: Utility.dynamicWidth(0.04)),
                        child: Text(
                          "Son Harcamalar",
                          style: TextStyleManager.instance.headline5BlackMedium,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: Utility.dynamicWidth(0.04)),
                        child: InkWell(
                          onTap: () {
                            NavigationService.navigateToPage(context, NavigationConstants.recentExpensesView, widget.group);
                          },
                          child: Text(
                            "Tümünü Gör",
                            style: TextStyle(color: Colors.blue, fontSize: Utility.dynamicHeight(0.016)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Utility.dynamicHeight(0.02),
                  ),
                  for (int index = 0; index < lastExpenseList.length; index++)
                    listTileWidget(
                      categoryId: lastExpenseList[index].categoryId,
                      date: "${lastExpenseList[index].date.day}/${lastExpenseList[index].date.month}/${lastExpenseList[index].date.year}",
                      name: "${lastExpenseList[index].nameSurname}",
                      price: lastExpenseList[index].price,
                      currencyType: widget.group.currencyType,
                      function: () {
                        showModal(lastExpenseList[index]);
                      },
                    ),
                  SizedBox(
                    height: Utility.dynamicHeight(0.13),
                  ),
                ],
              ),
            ),
    );
  }

  Future getLastExpense() async {
    setState(() {
      loading = true;
    });
    await ExpenseService.instance.getExpenses(context: context, groupID: widget.group.id);
    lastExpenseList = ExpenseService.instance.expense.result;
    setState(() {
      loading = false;
    });
  }

  Future filterByCategory(int categoryId) async {
    lastExpenseList = ExpenseService.instance.getExpensesByCategoryId(categoryId);
  }

  showModal(Expense.Result expense) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Utility.borderRadius),
          topRight: Radius.circular(Utility.borderRadius),
        ),
      ),
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            height: Utility.dynamicHeight(0.3),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: Utility.dynamicHeight(0.02),
                ),
                listTileWidget(
                  categoryId: expense.categoryId,
                  date: "${expense.date.day}/${expense.date.month}/${expense.date.year}",
                  name: "${expense.nameSurname}",
                  price: expense.price,
                  currencyType: widget.group.currencyType,
                  function: null,
                ),
                SizedBox(
                  height: Utility.dynamicHeight(0.02),
                ),
                Padding(
                  padding: EdgeInsets.only(left: Utility.dynamicWidth(0.04)),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Açıklama:",
                      style: TextStyleManager.instance.headline3BlackBold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(Utility.dynamicWidth(0.04)),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      expense.note,
                      style: TextStyleManager.instance.headline5BlackRegular,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
