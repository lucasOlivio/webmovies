import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import "package:mobapp/class/api.dart";
import "package:mobapp/functions/widgetGenerator.dart";
import "package:mobapp/screen/mainScreen.dart";
import 'package:flutter/rendering.dart';
import 'screen/globals.dart' as globals;

API api = new API();
void main() {
  //debugPaintSizeEnabled = true; //Habilita debug layout
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Webmovies',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: HomePage(title: "WebMovies APP"),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false; //Validação automática ativada caso form. incorreto
  String _email;
  String _password;


  Widget formLogin(){
    return Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
                labelText: "E-mail"
            ),
            keyboardType: TextInputType.emailAddress,
//            validator: (String arg) {
//              Pattern pattern =  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//              RegExp regex = RegExp(pattern);
//              if((arg.length == 0) || !regex.hasMatch(arg)){
//                return "Digite um e-mail válido";
//              }else{
//                return null;
//              }
//            },
            onSaved: (String val) {
              _email = val;
            },
          ),

          TextFormField(
            decoration: InputDecoration(
                labelText: "Senha"
            ),
            obscureText: true,
            validator: (String arg) {
              if(arg.length < 6) {
                return "Digite uma senha válida";
              }else{
                return null;
              }
            },
            onSaved: (String val) {
              _password = val;
            },
          ),
          Padding(padding: EdgeInsets.only(bottom: 30),),
          RaisedButton(
            child: Text(
              "Entrar",
              semanticsLabel: "Entrar",
              style: new TextStyle(
                fontSize: 25.0,
              ),
            ),
            color: Colors.teal,
            textColor: Colors.white,
            onPressed: _validarLogin,
          ),
        ]);
  }

  void _validarLogin() async {
    bool _loginOK = true;
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    }else{
      _loginOK = false;
      setState(() {
        _autoValidate = true;
      });
    }

    if(_loginOK){
      var loading = buildLoading(context);

      try{
        var login = {'email':_email, 'senha': _password};
        var response = await api.requestAPI("login/", "POST", login);

        if(response['id']!=null){
          print("Usuário logado!");
          globals.id = response['id'];
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MainScreenTheme()));
        }else{
          print("Usuário não encontrado!");
          Navigator.pop(context, loading);
          buildAlert(context,"Usuário não encontrado!","Email/Senha incorretos");
        }
      }catch(e){
        print(e.toString());
        Navigator.pop(context, loading);
        buildAlert(context,"Ocorreu um erro!","Tente novamente em instantes");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(bottom: 100),),
                    Padding(
                        padding: EdgeInsets.only(top:0),
                        child: Text(
                          'Web Movies',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                            fontFamily: "LexendZetta",
                          ),
                        )
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 65),
                      child: Form(
                        key: _formKey,
                        autovalidate: _autoValidate,
                        child: formLogin(),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
}
