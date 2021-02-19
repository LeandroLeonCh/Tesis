import 'package:flutter/material.dart';

class Botones extends StatelessWidget {
  TextStyle estiloTexto = new TextStyle(fontSize: 30);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        Image(
          image: AssetImage('assets/logoOperation.PNG'),
        ),
        Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(height: 100.0),
              MaterialButton(
                minWidth: 200.0,
                height: 100.0,
                onPressed: () {
                  _submit((context));
                },
                color: Colors.lightBlue,
                child: Text('Registro de Paciente',
                    style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 10.0),
              MaterialButton(
                minWidth: 200.0,
                height: 100.0,
                onPressed: () {},
                color: Colors.lightBlue,
                child:
                    Text('Quirofanos', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        )
      ]),
    );
  }

  Future _submit(BuildContext context) async {
    Navigator.of(context).pushNamed('/tabla');
  }
}
