import 'dart:convert';
import 'package:qr_flutter/model/usuario.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/model/api_response.dart';

class UserService {
  static const API = "";
  static const headers = {'Content-Type': 'application/json'};

  Future<APIResponse<Usuario>> loginUsuario(
      String correo, String contrasena) async {
    print('------------------------------------- llamo servicio diego');
    return await http
        .post(API + '/logeo/',
            headers: headers,
            body: jsonEncode({'parametro1': correo, 'parametro2': contrasena}))
        .then((data) {
      print('respuesta----------------------------' + data.body);
    }).catchError((_) =>
            APIResponse<bool>(error: true, mensajeError: 'No se pudo loguear'));
  }
}
