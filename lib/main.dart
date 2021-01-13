import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Main(),
  ));
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController qtdPessoasController = TextEditingController();
  TextEditingController valorContaController = TextEditingController();
  String _msgCadaUmPaga = "Cada um paga";
  String _valorCalculado = "R\$ 0,00";

  void _calcular() {
    double qtdPessoas = double.parse(qtdPessoasController.text);
    double valorConta = double.parse(valorContaController.text);

    double valorDividido = (valorConta / qtdPessoas);
    String valorDivididoConverted = valorDividido.toStringAsPrecision(3);

    setState(() {
      _valorCalculado = "R\$: $valorDivididoConverted";
    });
  }

  void _limpaCampos() {
    setState(() {
      _valorCalculado = "R\$ 0,00";
      this.qtdPessoasController.text = "";
      this.valorContaController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Rachide"),
          backgroundColor: Colors.deepOrangeAccent,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  _limpaCampos();
                })
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: (Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.money,
                  size: 120,
                  color: Colors.green,
                ),
                TextFormField(
                  controller: qtdPessoasController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Quantidade de pessoas",
                      labelStyle: TextStyle(color: Colors.black54)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                  validator: (value) { if(value.isEmpty) return "Informe o número de pessoas"; },
                ),
                TextFormField(
                  controller: valorContaController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Valor da conta",
                      labelStyle: TextStyle(color: Colors.black54)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                  validator: (value) { if(value.isEmpty) return "Informe o valor da conta"; },
                ),
                Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: Container(
                      height: 40,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()){
                            this._calcular();
                          }
                        },
                        color: Colors.deepOrange,
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    )),
                Text(
                  _msgCadaUmPaga,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontSize: 24),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Container(
                    child: Text(
                      _valorCalculado,
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.redAccent, fontSize: 50),
                    ),
                  ),
                ),
              ],
            )),
          ),
        )));
  }
}
