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
              if(arg.length < 5) {
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
              onPressed: () {
                _validarLogin(0);
              }
          ),
          RaisedButton(
            child: Text(
              "Novo usuário",
              semanticsLabel: "Novo usuário",
              style: new TextStyle(
                fontSize: 25.0,
              ),
            ),
            color: Colors.teal,
            textColor: Colors.white,
            onPressed: () {
              _validarLogin(1);
            }
          ),
        ]);
  }

  void _validarLogin(int mode) async {
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
      var response;
      try{
        var login = {'email':_email, 'senha': _password};


        if(mode == 0){
          response = await api.requestAPI("login/", "POST", login);
        }else{
          response = await api.requestAPI("addusuario/", "POST", login);

          if(response['status']=='inserido'){
            print("Usuário logado!");
            response = await api.requestAPI("login/", "POST", login);
          }else{
            print(response['status']);
            Navigator.pop(context, loading);
            buildAlert(context,"Erro!",response['status']);
            return;
          }
        }
        print(response);
        if(response['id']!=null){
          print("Usuário logado!");
          globals.id = response['id'];
          globals.user = _email;
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MainScreenTheme()));
        }else{
          print(response[0]);
          Navigator.pop(context, loading);
          buildAlert(context,"Erro!",response[0]);
        }
      }catch(e){
        print(e.toString());
        Navigator.pop(context, loading);
        buildAlert(context,"Ocorreu um erro!",response[0]);
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
