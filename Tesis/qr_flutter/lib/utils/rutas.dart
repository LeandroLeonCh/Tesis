import 'package:flutter/material.dart';
import 'package:qr_flutter/src/registro_cirujias.dart';

Map<String, WidgetBuilder> builAppRoutes() {
  return {
    '/tabla': (BuildContext context) => new RegisterPage(),
  };
}
