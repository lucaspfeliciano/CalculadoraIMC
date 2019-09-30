import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      home: Home()
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  TextEditingController texto1Controller = TextEditingController();
  TextEditingController texto2Controller = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetFields() {
    texto1Controller.text = "";
    texto2Controller.text = "";
    setState(() {
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });


  }

  void _calculate() {
    double peso = double.parse(texto1Controller.text);
    double altura = double.parse(texto2Controller.text) / 100;
    double imc = peso / (altura * altura);
    if (imc < 18.6) {
      _infoText = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
    } else if (imc >= 18.6 && imc < 24.9) {
      _infoText = "Peso ideal (${imc.toStringAsPrecision(4)}";
    } else {
      _infoText = "Acima do peso (${imc.toStringAsPrecision(4)}";
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
            onPressed: _resetFields)
        ],
      ),
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 120.0, color: Colors.teal),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.teal)
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.teal, fontSize: 25.0),
                controller: texto1Controller,
                // ignore: missing_return
                validator: (value) {
                  if(value.isEmpty) {
                    return "Insira seu peso";
                  }
                },

              ),
              TextFormField(keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.teal)
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.teal, fontSize: 25.0),
                controller: texto2Controller,
                // ignore: missing_return
                validator: (value) {
                if(value.isEmpty) {
                  return "Insira sua altura!";
                }
                },

              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Container(height: 50.0,
                  child: RaisedButton(
                    onPressed: (){
                      if(_formKey.currentState.validate()) {
                        _calculate();
                      }
                    },
                    child: Text("Calcular",
                      style: TextStyle(color: Colors.transparent, fontSize: 25.0),),
                    color: Colors.teal,
                  ),
                ),
              ),
              Text("Info",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),)
            ],
          ),
        ) ,
      )
    );
  }
}
