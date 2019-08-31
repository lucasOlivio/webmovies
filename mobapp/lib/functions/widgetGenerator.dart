import "package:flutter/material.dart";

void buildAlert(context,title,msg){ //Exibe modal na tela
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(msg),
        actions: <Widget>[
          FlatButton(
            child: Text("Fechar"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void buildLoading(context){ //Exibe carregamento na tela
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
          title: Text('Carregando'),
          content: Padding(
              padding: EdgeInsets.fromLTRB(95.0, 0.0, 95.0, 0),
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
              )
          )
      );
    },
  );
}