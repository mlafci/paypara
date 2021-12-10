import 'package:flutter/material.dart';
import 'package:paypara/core/base/state/utility.dart';
import 'package:paypara/core/init/theme/text_style_manager.dart';
import 'package:paypara/ui/view_models/list_tile/list_tile_model.dart';
import 'package:paypara/ui/widgets/appBar.dart';
import 'package:paypara/ui/widgets/listTile.dart';

class RecentExpensesView extends StatefulWidget {
  RecentExpensesView({Key key}) : super(key: key);

  @override
  _RecentExpensesViewState createState() => _RecentExpensesViewState();
}

class _RecentExpensesViewState extends State<RecentExpensesView> {
  ListTileModel listTile;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    listTile = ListTileModel(
      leading: CircleAvatar(
        child: Icon(Icons.ac_unit),
      ),
      title: Text('Shopping'),
      subtitle: Text('22.12.2021'),
      trailing: Text(
        '-2.000',
        style: TextStyle(color: Colors.red),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Utility.height = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;
    Utility.width = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
    return Scaffold(
        appBar: appBar(
            text: 'Son Harcamalar',
            isBack: true,
            action: Padding(
              padding: EdgeInsets.all(15.0),
              child: IconButton(
                icon: Icon(Icons.date_range),
                onPressed: () => _selectDate(context),
                color: Colors.red,
              ),
            )),
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
                  height: Utility.dynamicHeight(0.23),
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return listTileWidget(listTileModel: listTile);
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
                  height: Utility.dynamicHeight(0.45),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return listTileWidget(listTileModel: listTile);
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
