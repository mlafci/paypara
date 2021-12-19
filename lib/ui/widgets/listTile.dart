import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paypara/core/init/theme/color_manager.dart';
import 'package:paypara/core/constants/app_constant.dart';

Widget listTileWidget({int categoryId, String subtitle, int price, int currencyType}) {
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
    "color": ColorManager.instance.blue,
  },
  {
    "id": 3,
    "icon": CupertinoIcons.house_alt,
    "name": "Kira",
    "color": ColorManager.instance.blue,
  },
  {
    "id": 4,
    "icon": CupertinoIcons.music_note,
    "name": "Eğlence",
    "color": ColorManager.instance.blue,
  },
  {
    "id": 5,
    "icon": CupertinoIcons.device_phone_portrait,
    "name": "Elektronik",
    "color": ColorManager.instance.blue,
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
    "color": ColorManager.instance.blue,
  },
  {
    "id": 8,
    "icon": CupertinoIcons.ellipsis_vertical,
    "name": "Diğer",
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