import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paypara/core/base/state/utility.dart';
import 'package:paypara/core/init/theme/color_manager.dart';
import 'package:paypara/core/constants/app_constant.dart';
import 'package:paypara/core/init/theme/text_style_manager.dart';

Widget listTileWidget({int categoryId, String date, String name, int price, int currencyType, Function function}) {
  return ListTile(
    onTap: function,
    leading: Container(
      width: Utility.dynamicHeight(0.05),
      height: Utility.dynamicHeight(0.05),
      decoration: BoxDecoration(
        color: getCategoryColor(categoryId),
        borderRadius: BorderRadius.circular(Utility.dynamicHeight(0.012)),
      ),
      child: Icon(
        getCategoryIcon(categoryId),
        color: ColorManager.instance.white,
        size: Utility.dynamicHeight(0.03),
      ),
    ),
    title: Text(
      getCategoryName(categoryId),
      style: TextStyle(
        fontSize: Utility.dynamicHeight(0.02),
        fontFamily: TextStyleManager.instance.medium,
      ),
    ),
    subtitle: Row(
      children: [
        Container(
          width: Utility.dynamicWidth(0.2),
          child: Text(
            date,
            style: TextStyle(
              fontSize: Utility.dynamicHeight(0.015),
              fontFamily: TextStyleManager.instance.medium,
            ),
          ),
        ),
        SizedBox(
          width: Utility.dynamicWidth(0.01),
        ),
        Text(
          name,
          style: TextStyle(
            fontSize: Utility.dynamicHeight(0.015),
            fontFamily: TextStyleManager.instance.medium,
          ),
        ),
      ],
    ),
    trailing: Text(
      '- $price ${ApplicationConstants.currencyList[currencyType]}',
      style: TextStyle(
        color: Colors.red,
        fontSize: Utility.dynamicHeight(0.015),
        fontFamily: TextStyleManager.instance.medium,
      ),
    ),
  );
}

List<Map<String, dynamic>> categories = [
  {
    "id": 0,
    "icon": CupertinoIcons.house,
    "name": "Market",
    "color": ColorManager.instance.pink,
  },
  {
    "id": 1,
    "icon": CupertinoIcons.gauge_badge_plus,
    "name": "Akaryakıt",
    "color": ColorManager.instance.blue,
  },
  {
    "id": 2,
    "icon": CupertinoIcons.doc_chart,
    "name": "Fatura",
    "color": Color(0xffee6c4d),
  },
  {
    "id": 3,
    "icon": CupertinoIcons.house_alt,
    "name": "Kira",
    "color": Color(0xff87bba2),
  },
  {
    "id": 4,
    "icon": CupertinoIcons.music_note,
    "name": "Eğlence",
    "color": Color(0xff778da9),
  },
  {
    "id": 5,
    "icon": CupertinoIcons.device_phone_portrait,
    "name": "Elektronik",
    "color": ColorManager.instance.pink,
  },
  {
    "id": 6,
    "icon": Icons.loyalty,
    "name": "Giyim",
    "color": ColorManager.instance.blue,
  },
  {
    "id": 7,
    "icon": Icons.local_cafe_outlined,
    "name": "Restorant&Cafe",
    "color": Color(0xffee6c4d),
  },
  {
    "id": 8,
    "icon": CupertinoIcons.ellipsis_vertical,
    "name": "Diğer",
    "color": Color(0xff87bba2),
  },
];

IconData getCategoryIcon(int categoryId) {
  IconData icon = CupertinoIcons.question;
  categories.forEach((category) {
    if (category["id"] == categoryId) {
      icon = category["icon"];
    }
  });
  return icon;
}

String getCategoryName(int categoryId) {
  String name = "Kategori";
  categories.forEach((category) {
    if (category["id"] == categoryId) {
      name = category["name"];
    }
  });
  return name;
}

Color getCategoryColor(int categoryId) {
  Color color = Colors.white;
  categories.forEach((category) {
    if (category["id"] == categoryId) {
      color = category["color"];
    }
  });
  return color;
}
