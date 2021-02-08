import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>(); // chave global

  String info = "informe seus dados!";

  void resetFields() {
    setState(() {
      weightController.text = "";
      heightController.text = "";
      info = "informe seus dados!";
      formKey = GlobalKey<FormState>();
    });
  }

  void calculateApp() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100; // convert
      double imc = weight / (height * height);
      if (imc < 18.5) {
        info = "abaixo do peso ideal";
      } else if (imc >= 18.5 && imc <= 24.9) {
        info = "seu peso está normal";
      } else if (imc >= 25 && imc <= 29.9) {
        info = "você está com sobrepeso";
      } else if (imc >= 30 && imc <= 34.9) {
        info = "Obesidade em grau I";
      } else if (imc >= 35 && imc <= 39.9) {
        info = "obesidade em grau II";
      } else if (imc >= 40) {
        info = "Obesidade em grau III";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calcule seu IMC'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.person_outline_sharp,
                  size: 120.0,
                  color: Colors.green,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'peso',
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: weightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira seu peso";
                    }
                    return null; // return if
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'altura(cm)',
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                  controller: heightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "insira sua altura";
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          calculateApp();
                        }
                      },
                      color: Colors.green,
                      child: Text(
                        'Calcular',
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                      ),
                    ),
                  ),
                ),
                Text(
                  info,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                )
              ],
            ),
          )),
    );
  }
}
