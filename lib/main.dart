import 'package:flutter/material.dart';

import 'package:bytebank/routes.dart';
import 'package:bytebank/styles/material_styles.dart';

void main() {
  runApp(Bytebank());
}

class Bytebank extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: materialTheme,
      initialRoute: '/',
      routes: appRoutes(context),
    );
  }
}
