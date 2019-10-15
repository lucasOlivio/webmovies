import 'package:flutter/material.dart';
import 'package:mobapp/screen/globals.dart' as globals;
import "package:mobapp/class/api.dart";
import 'package:mobapp/screen/mainScreen.dart';

class UsersTheme extends StatelessWidget {
  @override

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Webmovies',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Users(title: "WebMovies APP"),
    );
  }
}

class Users extends StatefulWidget {
  final String title;
  Users({Key key, this.title}) : super(key: key);

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {

  _UsersState(){
    getUsers();
  }
  API api = new API();

  void getUsers() async{
    var post = {'usuario': globals.id.toString()};
    var response = await api.requestAPI("usuarios/", "GET", post);

    setState(() {
      globals.users = response;
    });
  }

  void removeUser(index) async{
    Map<String, String> post = {
      'id': globals.users[index]['id'].toString()
    };
    var response = await api.requestAPI("removeusuario/", "DELETE", post);

    setState(() {
      globals.users.removeAt(index);
    });
  }

  Widget buildUsers(){

    //80% of screen width
    double c_width = MediaQuery.of(context).size.width*0.4;

    return (globals.users==null?Container():new ListView.builder(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.all(15),
      itemCount: globals.users.length,
      itemBuilder: (context, index){
        return Padding(
            padding: EdgeInsets.all(5),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(width: 3, color: Color.fromRGBO(24, 180, 168, 1)),
                      left: BorderSide(width: 3, color: Color.fromRGBO(24, 180, 168, 1)),
                      right: BorderSide(width: 3, color: Color.fromRGBO(24, 180, 168, 1)),
                      bottom: BorderSide(width: 3, color: Color.fromRGBO(24, 180, 168, 1)),
                    )
                ),
                child: Container(
                    width: c_width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Text(
                              globals.users[index]['email'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26,
                                  color: Color.fromRGBO(24, 180, 168, 1)
                              ),
                            )
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            child: ClipOval(
                              child: Container(
                                color: Colors.red,
                                child: IconButton(
                                    onPressed: () => {
                                      removeUser(index)
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    )
                                ),
                              ),
                            )
                        )
                      ],
                    )
                )
            )
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
          actions: [

            new IconButton(
              icon: new Icon(Icons.format_list_numbered),
              tooltip: 'Info',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => globals.buildAboutDialog(context, 'Devido a limitações de API o sistema só busca informações sobre o mercado de ações norte-americano NASDAQ'),
                );
              },
            ),

          ],
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: ButtonTheme(
                buttonColor: Colors.blueAccent,
                minWidth: double.infinity,
                child: FlatButton(
                  color: Colors.blueAccent,
                  onPressed: () {
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MainScreenTheme()));
                  },
                  child: Text('Voltar',style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                  height: 200.0,
                  child: buildUsers()
              ),
            )
          ],
        )
    );
  }
}