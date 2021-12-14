import 'package:flutter/material.dart';
import 'package:paypara/core/base/state/utility.dart';
import 'package:paypara/core/init/theme/text_style_manager.dart';
import 'package:paypara/models/group/group.dart';
import 'package:paypara/ui/view_models/list_tile/list_tile_model.dart';
import 'package:paypara/ui/widgets/appBar.dart';
import 'package:paypara/ui/widgets/listTile.dart';

class RecentExpensesView extends StatefulWidget {
  final GroupDetail group;
  RecentExpensesView({this.group});

  @override
  _RecentExpensesViewState createState() => _RecentExpensesViewState();
}

class _RecentExpensesViewState extends State<RecentExpensesView> {
  DateTime selectedDate = DateTime.now();

  List<Map<String, dynamic>> expenses = [
    {
      "categoryId": 1,
      "price": 0,
      "date": "2021-12-12",
    },
    {
      "categoryId": 2,
      "price": 0,
      "date": "2021-12-12",
    },
    {
      "categoryId": 1,
      "price": 0,
      "date": "2021-12-12",
    },
  ];

  @override
  Widget build(BuildContext context) {
    Utility.height =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;
    Utility.width =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
    return Scaffold(
        appBar: appBar(
          text: 'Son Harcamalar',
          isBack: true,
          actions: [
            Padding(
              padding: EdgeInsets.all(15.0),
              child: IconButton(
                icon: Icon(Icons.date_range),
                onPressed: () => _selectDate(context),
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
                      'Bugün',
                      style: TextStyleManager.instance.headline4BlackMedium,
                    ),
                  ),
                ),
                Container(
                  height: Utility.dynamicHeight(0.3),
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: expenses.length,
                      itemBuilder: (context, index) {
                        return listTileWidget(
                          categoryId: expenses[index]['categoryId'],
                          subtitle: expenses[index]['date'],
                          price: expenses[index]['price'],
                          currencyType: widget.group.currencyType,
                        );
                      }),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.all(Utility.dynamicWidth(0.03)),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Geçen Hafta',
                      style: TextStyleManager.instance.headline4BlackMedium,
                    ),
                  ),
                ),
                Container(
                  height: Utility.dynamicHeight(0.3),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: expenses.length,
                      itemBuilder: (context, index) {
                        return listTileWidget(
                          categoryId: expenses[index]['categoryId'],
                          subtitle: expenses[index]['date'],
                          price: expenses[index]['price'],
                          currencyType: widget.group.currencyType,
                        );
                      }),
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
      });
  }
}