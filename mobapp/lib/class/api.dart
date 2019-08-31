import "dart:async";
import "package:http/http.dart" as http;
import "dart:convert" as JSON; //Conversão de JSON

class API{
  API();

  String buildGETRequest(Map get){
    String req = '?';

    get.forEach((i, val) => {
      req += i+'='+val+'&'
    });

    return req;
  }

  Future requestAPI(String suburl, String method, Map post) async{ //Ajustar conexão com API
    //Chamada local
    final String url = "http://10.0.2.2:2000/"+suburl+(method=='GET'?buildGETRequest(post):'');

    var client = new http.Client();
    var request = new http.Request(method, Uri.parse(url));

    var body = post;
    request.bodyFields = body;

    var retornoData = await client.send(request)
        .then((response) => response.stream.bytesToString()
        .then((value){
      var valueDecoded = JSON.jsonDecode(value);
      return valueDecoded;
    })
    )
        .catchError((error) => print(error.toString()));

    return retornoData;
  }

}

bool isNumeric(String s) {
  if(s == null) {
    return false;
  }
  return double.parse(s, (e) => null) != null;
}