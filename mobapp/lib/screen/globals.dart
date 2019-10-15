import 'package:flutter/material.dart';

int id = 0;
String user = '';

// Array com a lista dos filmes do usuário
var filmes = [];
var ranking = '';

// Array com a lista dos usuarios
var users = [];

Widget buildAboutText(texto) {
  return new RichText(
    text: new TextSpan(
      text: texto,
      style: const TextStyle(color: Colors.black87),
    ),
  );
}

Widget buildAboutDialog(BuildContext context, texto) {
  return new AlertDialog(
    title: const Text('Info'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildAboutText(texto),
      ],
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Ok'),
      ),
    ],
  );
}