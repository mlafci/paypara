import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paypara/core/init/theme/color_manager.dart';
import 'package:paypara/core/constants/app_constant.dart';

Widget listTileWidget(
    {int categoryId, String subtitle, int price, int currencyType}) {
  return Card(
    child: ListTile(
      onTap: () {},
      leading: CircleAvatar(
        backgroundColor: getCategoryColor(categoryId),
        child: Icon(
          getCategoryIcon(categoryId),
          color: ColorManager.instance.white,
        ),
      ),
      title: Text(
        getCategoryName(categoryId),
      ),
      subtitle: Text(subtitle),
      trailing: Text(
        '- $price ${ApplicationConstants.currencyList[currencyType]}',
        style: TextStyle(color: Colors.red),
      ),
    ),
  );
}

List<Map<String, dynamic>> categories = [
  {
    "id": 1,
    "icon": Icons.local_pizza_outlined,
    "name": "Yemek",
    "color": ColorManager.instance.pink,
  },
  {
    "id": 2,
    "icon": Icons.local_drink,
    "name": "İçecek",
    "color": ColorManager.instance.blue,
  },
  {
    "id": 2,
    "icon": Icons.local_drink,
    "name": "İçecek",
    "color": ColorManager.instance.blue,
  },
  {
    "id": 2,
    "icon": Icons.local_drink,
    "name": "İçecek",
    "color": ColorManager.instance.blue,
  },
  {
    "id": 2,
    "icon": Icons.local_drink,
    "name": "İçecek",
    "color": ColorManager.instance.blue,
  },
  {
    "id": 2,
    "icon": Icons.local_drink,
    "name": "İçecek",
    "color": ColorManager.instance.blue,
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
