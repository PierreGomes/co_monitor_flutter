// import '';

import 'dart:convert';

class JsonObject {
  String CO;
  String Datetime;
  String Lux;
  String Temp;
  String Umid;

  JsonObject({
    required this.CO,
    required this.Datetime,
    required this.Lux,
    required this.Temp,
    required this.Umid
  });

  Map<String,dynamic>toMap(){
    return{
      'CO'       : CO,
      'Datetime' : Datetime,
      'Lux'      : Lux,
      'Temp'     : Temp,
      'Umid'     : Umid,
    };
  }

  factory JsonObject.fromMap(Map<String,dynamic>map){
    return JsonObject(
      CO        : map['CO']??'',
      Datetime  : map['Datetime']?? '',
      Lux       : map['Lux']?? '',
      Temp      : map['Temp']??'',
      Umid      : map['Umid'],
      );
  }

  String toJson()=>json.encode(toMap());
  
  factory JsonObject.fromJson(String source)=>JsonObject.fromMap(json.decode(source));
}