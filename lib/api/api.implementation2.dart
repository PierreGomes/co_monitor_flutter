import 'dart:convert';
import 'dart:io';


import 'package:co_monitor/api/objects/json.object2.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_connect/http/src/request/request.dart';

import './objects/api.interface2.dart';
import 'package:http/http.dart' as http;

class Api_2 implements ApiInterface{

  @override
  Future<List<JsonObject>> getJsonData(String dtInicio, String dtFinal) async {

    var params = {
      "dtInicio": dtInicio?? "2022-06-29",
      "dtFinal": dtFinal?? "2022-06-29" 
    };

    String url = "http://13.58.175.85:8081/dados";
    String url_testes = "https://kelvinseibt.pythonanywhere.com/testes";

    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse(url_testes));
    request.body = json.encode({
      "dtInicio": "2022-06-21",
      "dtFinal": "2022-06-30"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String response_body = await response.stream.bytesToString();
      debugPrint(response_body);

      List  mapped = jsonDecode(response_body);

      List<JsonObject> JsonObjects = mapped.map( (f) => JsonObject.fromMap(f)).toList();

      return JsonObjects;

    }
    else {
      debugPrint(response.reasonPhrase);
    }

    return jsonDecode("{\"error\": \"true\"}");

  }
}

// $2b$10$1.tbfpSUkaj8EiFf0KN1AuTHdvjHDHkZYlhvrnwMHfYFacyYXnw2a
