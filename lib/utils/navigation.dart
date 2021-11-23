import 'package:flutter/material.dart';

Map getNavigatorArguments(BuildContext context) {
  final Map arguments = ModalRoute.of(context).settings.arguments;
  return arguments;
}
