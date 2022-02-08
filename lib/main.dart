// ignore_for_file: prefer_const_constructors

import 'dart:ffi';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FormularioTransferencia(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _controladorNumeroConta =
        TextEditingController();
    final TextEditingController _controladorValor = TextEditingController();

    return Scaffold(
        appBar: AppBar(title: Text("Registro de Transferência")),
        body: Column(
          children: [
            Editor(_controladorNumeroConta, "Número da Conta", "0000",
                Icons.account_circle),
            Editor(_controladorValor, "Valor", "0.00", Icons.monetization_on),
            ElevatedButton(
                onPressed: () {
                  final int numeroConta =
                      int.parse(_controladorNumeroConta.text);
                  final double valor = double.parse(_controladorValor.text);
                  if (numeroConta != null || valor != null) {
                    final transferenciaCriada =
                        Transferencia(numeroConta: numeroConta, valor: valor);
                  }
                },
                child: Text("Confirmar")),
          ],
        ));
  }
}

class ListaTransferencia extends StatelessWidget {
  const ListaTransferencia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transferencias')),
      body: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          ItemTransferencia(Transferencia(numeroConta: 1000, valor: 100)),
          ItemTransferencia(Transferencia(numeroConta: 1001, valor: 500)),
        ],
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () {}, child: Icon(Icons.add)),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: Icon(Icons.monetization_on),
      title: Text(_transferencia.valor.toString()),
      subtitle: Text(_transferencia.numeroConta.toString()),
    ));
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia({
    required this.valor,
    required this.numeroConta,
  });

  @override
  String toString() =>
      'Transferencia(valor: $valor, numeroConta: $numeroConta)';
}

class Editor extends StatelessWidget {
  final TextEditingController _controlador;
  final String _text;
  final String _dica;
  final IconData _icone;

  Editor(this._controlador, this._text, this._dica, this._icone);

  // ignore: empty_constructor_bodies
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _controlador,
        style: TextStyle(fontSize: 24),
        decoration: InputDecoration(
          icon: Icon(_icone),
          labelText: _text,
          hintText: _dica,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
