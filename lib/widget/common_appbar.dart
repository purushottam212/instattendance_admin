import 'package:flutter/material.dart';

PreferredSizeWidget appbar(
  String title,
  BuildContext context,
) {
  return AppBar(
    backgroundColor: Theme.of(context).primaryColorLight,
    title: Text(title),
  );
}
