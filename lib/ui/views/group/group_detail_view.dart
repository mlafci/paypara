import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paypara/core/base/state/utility.dart';
import 'package:paypara/core/init/theme/color_manager.dart';
import 'package:paypara/core/init/theme/text_style_manager.dart';
import 'package:paypara/ui/widgets/appBar.dart';
import 'package:paypara/ui/widgets/listTile.dart';

class GroupDetailView extends StatefulWidget {
  @override
  _GroupDetailViewState createState() => _GroupDetailViewState();
}

class _GroupDetailViewState extends State<GroupDetailView> {
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
    return Scaffold(
      appBar: appBar(
        context: context,
        text: "Ev Arkadaşlarım",
        isBack: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
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
      body: Column(
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
                  padding: EdgeInsets.only(right: Utility.dynamicWidth(0.05)),
                  child: Column(
                    children: [
                      Container(
                        width: Utility.dynamicHeight(0.08),
                        height: Utility.dynamicHeight(0.08),
                        decoration: BoxDecoration(
                          color: categories[index]["color"],
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
                        style: TextStyleManager.instance.headline5BlackRegular,
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
            children: [
              SizedBox(
                width: Utility.dynamicWidth(0.05),
              ),
              Text(
                "Son Harcamalar",
                style: TextStyleManager.instance.headline2BlackMedium,
              ),
            ],
          ),
          SizedBox(
            height: Utility.dynamicHeight(0.02),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                return listTileWidget(
                  categoryId: expenses[index]['categoryId'],
                  date: expenses[index]['date'],
                  price: expenses[index]['price'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
