import 'dart:convert';


import 'package:co_monitor/api/objects/json.object.dart';
import 'package:flutter/widgets.dart';

import './objects/api.interface.dart';
import 'package:http/http.dart' as http;

class Api implements ApiInterface{
 
  @override
  Future<List<JsonObject>> getJsonData() async {
    final response = await http.get(
      Uri.parse('https://pierregomes.pythonanywhere.com/data')
    );

    List  mapped = jsonDecode(response.body);

    List<JsonObject> JsonObjects = mapped.map( (f) => JsonObject.fromMap(f)).toList();

    return JsonObjects;
  }



}

// $2b$10$1.tbfpSUkaj8EiFf0KN1AuTHdvjHDHkZYlhvrnwMHfYFacyYXnw2a
