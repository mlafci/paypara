import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paypara/ui/view_models/list_tile/list_tile_model.dart';

Widget listTileWidget({
  @required ListTileModel listTileModel,
}) {
  return Card(
    child: ListTile(
      leading: listTileModel.leading,
      title: listTileModel.title,
      subtitle: listTileModel.subtitle,
      trailing: listTileModel.trailing,
    ),
  );
}
