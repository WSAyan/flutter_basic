import 'package:flutter/material.dart';
import 'package:flutter_basic/utils/routes.dart';
import 'package:flutter_basic/utils/routes.dart' as routes;

void main() {
  runApp(BasicApp());
}

class BasicApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: routes.SPLASH,
        routes: RouteManager(context).routes(),
        onGenerateRoute: RouteManager(context).handleRoutesWithParam);
  }
}
