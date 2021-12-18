import 'package:flutter/material.dart';
import 'package:paypara/core/base/state/utility.dart';
import 'package:paypara/core/init/theme/text_style_manager.dart';
import 'package:paypara/core/utils/date_util.dart';
import 'package:paypara/models/group/group.dart';
import 'package:paypara/services/expense/expense_service.dart';
import 'package:paypara/ui/widgets/appBar.dart';
import 'package:paypara/ui/widgets/listTile.dart';
import 'package:intl/intl.dart';

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
            Padding(
              padding: EdgeInsets.all(15.0),
              child: IconButton(
                icon: Icon(Icons.date_range),
                onPressed: () {
                  _selectDate(context);
                },
                color: Colors.red,
              ),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(Utility.dynamicWidth(0.04)),
          child: Container(
            width: Utility.width,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(Utility.dynamicWidth(0.03)),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      filteredText,
                      style: TextStyleManager.instance.headline4BlackMedium,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredExpenses.length,
                    itemBuilder: (context, index) {
                      return listTileWidget(
                          categoryId: filteredExpenses[index].categoryId,
                          subtitle:
                              "${filteredExpenses[index].date.day}/${filteredExpenses[index].date.month}/${filteredExpenses[index].date.year}     (${filteredExpenses[index].nameSurname})",
                          price: filteredExpenses[index].price,
                          currencyType: widget.group.currencyType);
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.all(Utility.dynamicWidth(0.03)),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Geçmiş Harcamalar',
                      style: TextStyleManager.instance.headline4BlackMedium,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: lastExpenses.length,
                    itemBuilder: (context, index) {
                      return listTileWidget(
                          categoryId: lastExpenses[index].categoryId,
                          subtitle:
                              "${lastExpenses[index].date.day}/${lastExpenses[index].date.month}/${lastExpenses[index].date.year}     (${lastExpenses[index].nameSurname})",
                          price: lastExpenses[index].price,
                          currencyType: widget.group.currencyType);
                    },
                  ),
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
          filteredText = picked.getDateFormat("dd-MMM-yyyy");
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
}
