import "package:flutter/material.dart";
import 'package:qr_flutter/src/homebotones.dart';
import 'package:qr_flutter/src/login.dart';
import 'package:qr_flutter/utils/rutas.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget routePage = LoginPage();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: routePage,
        routes: builAppRoutes());
    print("");
  }
}
