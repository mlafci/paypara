import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paypara/core/base/state/utility.dart';
import 'package:paypara/core/init/theme/text_style_manager.dart';
import 'package:paypara/core/utils/date_util.dart';
import 'package:paypara/models/group/group.dart';
import 'package:paypara/services/expense/expense_service.dart';
import 'package:paypara/ui/widgets/appBar.dart';
import 'package:paypara/ui/widgets/listTile.dart';
import 'package:paypara/models/expense/expense.dart' as Expense;

class RecentExpensesView extends StatefulWidget {
  final GroupDetail group;
  RecentExpensesView({this.group});

  @override
  _RecentExpensesViewState createState() => _RecentExpensesViewState();
}

class _RecentExpensesViewState extends State<RecentExpensesView> {
  DateTime selectedDate = DateTime.now();
  bool loading = false;
  DateTime currentDate = DateTime.now();
  String filteredText = 'Bugün';
  List<String> days = [
    "Pazartesi",
    "Salı",
    "Çarşamba",
    "Perşembe",
    "Cuma",
    "Cumartesi",
    "Pazar",
  ];
  @override
  void initState() {
    getLastExpensesByDate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Utility.height = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;
    Utility.width = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;

    var filteredExpenses = ExpenseService.instance.getExpensesByDate(currentDate);
    var lastExpenses = ExpenseService.instance.getLastExpenses();

    return Scaffold(
        appBar: appBar(
          context: context,
          text: 'Son Harcamalar',
          isBack: true,
          actions: [
            IconButton(
              icon: Icon(Icons.date_range),
              onPressed: () {
                _selectDate(context);
              },
              color: Colors.red,
              splashRadius: Utility.dynamicHeight(0.027),
              iconSize: Utility.dynamicHeight(0.035),
            )
          ],
        ),
        body: Container(
          width: Utility.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                (filteredExpenses.length != 0)
                    ? Column(
                        children: [
                          SizedBox(
                            height: Utility.dynamicHeight(0.02),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: Utility.dynamicWidth(0.04)),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                filteredText,
                                style: TextStyleManager.instance.headline4BlackMedium,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Utility.dynamicHeight(0.02),
                          ),
                          for (int index = 0; index < filteredExpenses.length; index++)
                            listTileWidget(
                              categoryId: filteredExpenses[index].categoryId,
                              date: "${filteredExpenses[index].date.day}/${filteredExpenses[index].date.month}/${filteredExpenses[index].date.year}",
                              name: "${filteredExpenses[index].nameSurname}",
                              price: filteredExpenses[index].price,
                              currencyType: widget.group.currencyType,
                              function: () {
                                showModal(filteredExpenses[index]);
                              },
                            ),
                        ],
                      )
                    : Container(),
                SizedBox(
                  height: Utility.dynamicHeight(0.02),
                ),
                Padding(
                  padding: EdgeInsets.only(left: Utility.dynamicWidth(0.04)),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Geçmiş Harcamalar',
                      style: TextStyleManager.instance.headline4BlackMedium,
                    ),
                  ),
                ),
                SizedBox(
                  height: Utility.dynamicHeight(0.02),
                ),
                for (int index = 0; index < lastExpenses.length; index++)
                  listTileWidget(
                    categoryId: lastExpenses[index].categoryId,
                    date: "${lastExpenses[index].date.day}/${lastExpenses[index].date.month}/${lastExpenses[index].date.year}",
                    name: "${lastExpenses[index].nameSurname}",
                    price: lastExpenses[index].price,
                    currencyType: widget.group.currencyType,
                    function: () {
                      showModal(lastExpenses[index]);
                    },
                  ),
              ],
            ),
          ),
        ));
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        currentDate = picked;
        if (picked.compareDate(DateTime.now())) {
          filteredText = "Bugün";
        } else {
          filteredText = "${days[picked.weekday]}  ${picked.getDateFormat("dd/MM/yyyy")}";
        }
      });
  }

  Future getLastExpensesByDate() async {
    setState(() {
      loading = true;
    });
    await ExpenseService.instance.getExpenses(context: context, groupID: widget.group.id);
    setState(() {
      loading = false;
    });
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
