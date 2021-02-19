import 'dart:core';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class RegisterPage extends StatefulWidget {
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> keyForm = new GlobalKey();
  TextEditingController nameCtrl = new TextEditingController();
  TextEditingController fechaNacimiento = new TextEditingController(); //----
  TextEditingController procedimientoMedico = new TextEditingController();
  TextEditingController emailCtrl = new TextEditingController();
  TextEditingController mobileCtrl = new TextEditingController();
  TextEditingController passwordCtrl = new TextEditingController();
  TextEditingController repeatPassCtrl = new TextEditingController();
  TextEditingController enfermedad = new TextEditingController();

  List<Enfermedades> _enfermedades = Enfermedades.getCompanies();
  List<DropdownMenuItem<Enfermedades>> _dropdownMenuItems;
  Enfermedades _selectEnfermedad;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_enfermedades);
    _selectEnfermedad = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Enfermedades>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Enfermedades>> items = List();
    for (Enfermedades company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Enfermedades selectEnfermedad) {
    setState(() {
      _selectEnfermedad = selectEnfermedad;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Registrarse'),
        ),
        body: new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(10.0),
            child: new Form(
              key: keyForm,
              child: formUI(),
            ),
          ),
        ),
      ),
    );
  }

  formItemsDesign(icon, item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Card(child: ListTile(leading: Icon(icon), title: item)),
    );
  }

  String tipoCirujia = 'hombre';

  Widget formUI() {
    return Column(
      children: <Widget>[
        Container(
          child: Column(
            children: [
              new ListTile(title: const Text('Datos Paciente')),
            ],
          ),
        ),
        formItemsDesign(
            Icons.person,
            TextFormField(
              controller: nameCtrl,
              decoration: new InputDecoration(
                labelText: 'Nombre del Paciente',
              ),
              validator: validateName,
            )),
        formItemsDesign(
            Icons.mode_outlined,
            Column(children: <Widget>[
              new ListTile(
                title: const Text('Fecha de nacimiento'),
              ),
              Container(
                child: Column(
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(currentDate.year.toString() +
                            "/" +
                            currentDate.month.toString() +
                            "/" +
                            currentDate.day.toString()),
                        IconButton(
                          onPressed: () => selectDate(context),
                          icon: Icon(Icons.date_range),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                child: Column(
                  children: [
                    Text("Edad: " + age.toString()),
                  ],
                ),
              )

              // Text("Edad: "+ ),
            ])),
        formItemsDesign(
            Icons.phone,
            TextFormField(
              controller: mobileCtrl,
              decoration: new InputDecoration(
                labelText: 'Numero de telefono',
              ),
              keyboardType: TextInputType.phone,
              maxLength: 10,
              validator: validateMobile,
            )),
        Container(
          child: Column(
            children: [
              new ListTile(title: const Text('Tipo de Cirujía')),
            ],
          ),
        ),
        formItemsDesign(
            Icons.picture_in_picture_alt_outlined,
            Container(
              child: Column(
                children: [
                  Wrap(
                    children: [
                      crearRadio('emergencia', 'Emergencia'),
                      crearRadio('emergenciaDiferible', 'E. Diferible'),
                      crearRadio('electiva', 'Electiva'),
                      crearRadio('privada', 'Privada'),
                      crearRadio('rpis', 'RPIS'),
                    ],
                  ),
                ],
              ),
            )),
        Container(
          alignment: Alignment.bottomLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Seleccionar Enfermedad"),
                  DropdownButton(
                    value: _selectEnfermedad,
                    items: _dropdownMenuItems,
                    onChanged: onChangeDropdownItem,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Text('Enfermedad: ${_selectEnfermedad.name}'),
              ),
            ],
          ),
        ),
        formItemsDesign(
            Icons.coronavirus,
            TextFormField(
              controller: procedimientoMedico,
              decoration: new InputDecoration(
                labelText: 'Procedimiento a Realizar: ',
              ),
              //keyboardType: TextInputType.,
              maxLength: 32,
              validator: validateEmail,
            )),
        formItemsDesign(
          Icons.mode_outlined,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                new ListTile(
                  title: const Text('Fecha del Procedimiento: '),
                ),
                Row(
                  children: [
                    Text(currentDate.year.toString() +
                        "/" +
                        currentDate.month.toString() +
                        "/" +
                        currentDate.day.toString()),
                    IconButton(
                      onPressed: () => selectDate(context),
                      icon: Icon(Icons.date_range),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        formItemsDesign(
            null,
            Container(
              child: Column(
                children: [
                  new ListTile(
                    title: const Text('Fecha del Procedimiento: '),
                  ),
                  Container(
                    child: Column(
                      children: [
                        TimePickerSpinner(
                            is24HourMode: true,
                            normalTextStyle:
                                TextStyle(fontSize: 16, color: Colors.black),
                            highlightedTextStyle:
                                TextStyle(fontSize: 18, color: Colors.black),
                            spacing: 20,
                            itemHeight: 20,
                            isForce2Digits: true,
                            onTimeChange: (time) {
                              setState(() {
                                DateTime _dateTime = DateTime.now();
                                _dateTime = time;
                              });
                            })
                      ],
                    ),
                  )
                ],
              ),
            )),
        formItemsDesign(
            Icons.email,
            TextFormField(
              controller: emailCtrl,
              decoration: new InputDecoration(
                labelText: 'Email',
              ),
              keyboardType: TextInputType.emailAddress,
              maxLength: 32,
              validator: validateEmail,
            )),
        formItemsDesign(
            Icons.remove_red_eye,
            TextFormField(
              controller: passwordCtrl,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
              ),
            )),
        formItemsDesign(
            Icons.remove_red_eye,
            TextFormField(
              controller: repeatPassCtrl,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Repetir la Contraseña',
              ),
              validator: validatePassword,
            )),
        GestureDetector(
            onTap: () {
              save();
            },
            child: Container(
              margin: new EdgeInsets.all(30.0),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                gradient: LinearGradient(colors: [
                  Color(0xFF0EDED2),
                  Color(0xFF03A0FE),
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
              child: Text("Guardar",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
              padding: EdgeInsets.only(top: 16, bottom: 16),
            ))
      ],
    );
  }

//Variables Globales -------------------------
  var eleccionRadioButton;
// -------------------------------------------

//Mètodos
  Container crearRadio(String value, String text) {
    return Container(
      width: 145,
      child: Row(
        children: [
          Radio(
            value: value,
            groupValue: tipoCirujia,
            onChanged: (value) {
              setState(() {
                tipoCirujia = value;
                eleccionRadioButton = value;
              });
            },
          ),
          Text(
            text,
            style: TextStyle(fontSize: 14),
          )
        ],
      ),
    );
  }

  String validatePassword(String value) {
    print("valorrr $value passsword ${passwordCtrl.text}");
    if (value != passwordCtrl.text) {
      return "Las contraseñas no coinciden";
    }
    return null;
  }

  String validateName(String value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "El nombre es necesario";
    } else if (!regExp.hasMatch(value)) {
      return "El nombre debe de ser a-z y A-Z";
    }
    return null;
  }

  String validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "El telefono es necesariod";
    } else if (value.length != 10) {
      return "El numero debe tener 10 digitos";
    }
    return null;
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "El correo es necesario";
    } else if (!regExp.hasMatch(value)) {
      return "Correo invalido";
    } else {
      return null;
    }
  }

  DateTime currentDate = DateTime.now();
  // => 1555837118231
  int age = 0;
  calcularEdad(DateTime value) {
    DateTime currentDate = DateTime.now();
    age = currentDate.year - value.year;
    int month1 = currentDate.month;
    int month2 = value.month;
    int meses = 0;
    if (month2 > month1) {
      meses = 12 - (month2 - month1);
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = value.day;
      if (day2 > day1) {
        age--;
      }
    }

    print('La edad es' + age.toString() + 'y los meses' + meses.toString());
    return age;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1990),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
        print('llegue');
        print(calcularEdad(currentDate));
      });
  }

  save() {
    if (keyForm.currentState.validate()) {
      print("Nombre ${nameCtrl.text}");
      print("Telefono ${mobileCtrl.text}");
      print("Correo ${emailCtrl.text}");
      print("Tipo de enfermedad:" + eleccionRadioButton);
      keyForm.currentState.reset();
    }
  }
}

class Enfermedades {
  int id;
  String name;

  Enfermedades(this.id, this.name);

  static List<Enfermedades> getCompanies() {
    return <Enfermedades>[
      Enfermedades(1, 'Covid'),
      Enfermedades(2, 'Sida'),
      Enfermedades(3, 'Cáncer'),
      Enfermedades(4, 'Diabetes'),
      Enfermedades(5, 'Gripe'),
    ];
  }
}
