import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paypara/core/base/state/utility.dart';
import 'package:paypara/core/init/theme/color_manager.dart';
import 'package:paypara/core/init/theme/text_style_manager.dart';
import 'package:paypara/models/group/group.dart';
import 'package:paypara/services/expense/expense_service.dart';
import 'package:paypara/ui/view_models/text_input/text_input_model.dart';
import 'package:paypara/ui/widgets/appBar.dart';
import 'package:paypara/ui/widgets/listTile.dart';
import 'package:paypara/ui/widgets/textField.dart';

class NewExpenseView extends StatefulWidget {
  final GroupDetail group;
  NewExpenseView({this.group});
  @override
  _NewExpenseViewState createState() => _NewExpenseViewState();
}

class _NewExpenseViewState extends State<NewExpenseView> {
  TextInputModel price, note;
  int categoryID = 0;
  DateTime date = DateTime.now();

  @override
  void initState() {
    price = TextInputModel(
      hintText: "Tutar",
      icon: Icon(
        CupertinoIcons.money_dollar,
        color: ColorManager.instance.pink,
      ),
      textInputFormatter: [FilteringTextInputFormatter.digitsOnly],
    );
    note = TextInputModel(
      hintText: "Açıklama",
      icon: Icon(
        CupertinoIcons.doc,
        color: ColorManager.instance.pink,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Utility.height = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;
    Utility.width = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
    return Scaffold(
      appBar: appBar(text: 'Yeni Harcama', isBack: true, context: context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ExpenseService.instance.addExpense(
            context: context,
            groupID: widget.group.id,
            categoryID: categoryID,
            price: int.parse(price.controller.text),
            note: note.controller.text,
            date: date,
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
                    padding: EdgeInsets.only(right: Utility.dynamicWidth(0.05)),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          categoryID = index;
                        });
                      },
                      child: Column(
                        children: [
                          Container(
                            width: Utility.dynamicHeight(0.08),
                            height: Utility.dynamicHeight(0.08),
                            decoration: BoxDecoration(
                              color: (categoryID == index) ? ColorManager.instance.blue : ColorManager.instance.grey,
                              borderRadius: BorderRadius.circular(Utility.borderRadius),
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
                            style: TextStyle(
                              fontSize: Utility.dynamicHeight(0.015),
                              fontFamily: TextStyleManager.instance.regular,
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
              height: Utility.dynamicHeight(0.02),
            ),
            textField(textInputModel: price),
            SizedBox(
              height: Utility.dynamicHeight(0.02),
            ),
            textField(textInputModel: note),
            SizedBox(
              height: Utility.dynamicHeight(0.02),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: Utility.dynamicWidth(0.05)),
                  child: Text(
                    "${date.day} / ${date.month} / ${date.year}",
                    style: TextStyle(
                      fontSize: Utility.dynamicHeight(0.02),
                    ),
                  ),
                ),
                SizedBox(
                  width: Utility.dynamicWidth(0.05),
                ),
                IconButton(
                  onPressed: () {
                    _selectDate();
                  },
                  icon: Icon(
                    CupertinoIcons.calendar,
                    size: Utility.dynamicHeight(0.035),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _selectDate() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != date)
      setState(() {
        date = picked;
      });
  }
}
