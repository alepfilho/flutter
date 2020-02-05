import 'package:flutter/material.dart';

void main(){
runApp(MaterialApp(
  home: Home(),
));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Preencha todos os campos";

  void _resetFileds(){
    pesoController.text = "";
    alturaController.text = "";
    setState(() {
      _infoText = "Preencha todos os campos";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcular(){
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);
      if(imc < 18.6 ){
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
      }else if ( imc >= 18.6 && imc < 24.9 ){
        _infoText = "Peso ideal (${imc.toStringAsPrecision(3)})";
      }else if ( imc >= 24.9&& imc < 29.9 ){
        _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(3)})";
      }else if ( imc >= 29.9&& imc < 34.9 ){
        _infoText = "Obesidade 1 (${imc.toStringAsPrecision(3)})";
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: _resetFileds,)
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size:120.0, color: Colors.blue),
              TextFormField(keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Peso (kg)",
                  labelStyle: TextStyle(color: Colors.blue),
                ),
                controller: pesoController,
                validator: (value){
                  if(value.isEmpty){
                    return "Insira seu Peso";
                  }
                },
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue, fontSize: 25.0),),
              TextFormField(keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Altura (cm)",
                  labelStyle: TextStyle(color: Colors.blue),
                ),
                controller: alturaController,
                validator:  (value){
                  if(value.isEmpty){
                    return "Insira sua Altura";
                  }
                },
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue, fontSize: 25.0),),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Container(
                  height:60.0,
                  child: RaisedButton(
                      onPressed: (){
                        if( _formKey.currentState.validate() ){
                          _calcular();
                        }
                      },
                      child: Text("calcular",
                          style: TextStyle(color: Colors.white, fontSize: 25.0)),
                      color: Colors.blue
                  ),
                ),
              ),
              Text(_infoText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue, fontSize: 25.0))
            ],
          ),
        ),
      )
    );
  }
}
