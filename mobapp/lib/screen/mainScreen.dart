import 'package:flutter/material.dart';
import 'package:mobapp/screen/globals.dart' as globals;
import "package:mobapp/class/api.dart";

class MainScreenTheme extends StatelessWidget {
  @override

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Webmovies',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MainScreen(title: "WebMovies APP"),
    );
  }
}

class MainScreen extends StatefulWidget {
  final String title;
  MainScreen({Key key, this.title}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  _MainScreenState(){
    getMovies();
  }
  API api = new API();
  final _addFilme = TextEditingController();

  void getMovies() async{
    var post = {'usuario': globals.id.toString()};
    var response = await api.requestAPI("filmes/", "GET", post);

    setState(() {
      globals.filmes = response;
    });
  }

  void mudaVisto(index) async{
    setState(() {
      globals.filmes[index]['visto'] = !globals.filmes[index]['visto'];
    });

    Map<String, String> post = {
      'usuario': globals.id.toString(),
      'filme': globals.filmes[index]['filme'],
      'visto': globals.filmes[index]['visto'].toString()
    };
    var response = await api.requestAPI("checkfilme/", "PUT", post);
  }

  void removeFilme(index) async{
    Map<String, String> post = {
      'usuario': globals.id.toString(),
      'filme': globals.filmes[index]['filme']
    };
    var response = await api.requestAPI("removefilme/", "DELETE", post);

    setState(() {
      globals.filmes.removeAt(index);
    });
  }

  void addFilme(String filme) async{
    Map<String, String> post = {
      'usuario': globals.id.toString(),
      'filme': filme
    };
    var response = await api.requestAPI("addfilme/", "POST", post);

    await new Future.delayed(const Duration(seconds : 1));
    setState(() {
      getMovies();
      _addFilme.text = '';
    });
  }

  Widget buildMovies(){

    //80% of screen width
    double c_width = MediaQuery.of(context).size.width*0.4;

    return new ListView.builder(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.all(15),
      itemCount: globals.filmes.length,
      itemBuilder: (context, index){
        return Padding(
          padding: EdgeInsets.all(5),
          child: Container(
            decoration: BoxDecoration(
                color: (globals.filmes[index]['visto']?Color.fromRGBO(24, 180, 168, 1):Colors.white),
                border: Border(
                  top: BorderSide(width: 3, color: Color.fromRGBO(24, 180, 168, 1)),
                  left: BorderSide(width: 3, color: Color.fromRGBO(24, 180, 168, 1)),
                  right: BorderSide(width: 3, color: Color.fromRGBO(24, 180, 168, 1)),
                  bottom: BorderSide(width: 3, color: Color.fromRGBO(24, 180, 168, 1)),
                )
            ),
            child: Row(
              children: <Widget>[
                Image.network(
                    globals.filmes[index]['posterPath'],
                    width: 200
                ),
                Container(
                  width: c_width,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 100),
                        child: Text(
                          globals.filmes[index]['filme'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                              color: (globals.filmes[index]['visto']?Colors.white:Color.fromRGBO(24, 180, 168, 1))
                          ),
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 5),
                              child: (globals.filmes[index]['visto']?
                                ClipOval(
                                  child: Container(
                                    color: Colors.white,
                                    child: IconButton(
                                        onPressed: () => {
                                          mudaVisto(index)
                                        },
                                        icon: Icon(
                                          Icons.remove_circle,
                                          color: Colors.grey[400],
                                        )
                                    ),
                                  ),
                                ):
                                ClipOval(
                                child: Container(
                                  color: Color.fromRGBO(24, 180, 168, 1),
                                  child: IconButton(
                                      onPressed: () => {
                                        mudaVisto(index)
                                      },
                                      icon: Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.white,
                                      )
                                  ),
                                ),
                              ))
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: ClipOval(
                                child: Container(
                                  color: Colors.red,
                                  child: IconButton(
                                    onPressed: () => {
                                      removeFilme(index)
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
                    ],
                  )
                )
              ],
            )
          )
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromRGBO(24, 180, 168, 1),
                    width: 3
                  )
                )
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: TextField(
                    controller: _addFilme,
                    onSubmitted: (text) {
                      addFilme(text);
                    },
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal, width: 5.0)
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal[300], width: 5.0)
                        ),
                        labelText: "Nome do filme"
                    )
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 200.0,
                child: buildMovies()
              ),
            )
          ],
        )
    );
  }
}