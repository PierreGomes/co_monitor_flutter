// import '';

import 'dart:convert';

class JsonObject {
  // String id;
  String co;
  String data;
  String temperatura;
  String temperatura2;
  String temperatura_cpu;
  String umidade;
  String umidade2;
  String pressao;

  JsonObject({
    // required this.id,
    required this.co,
    required this.data,
    required this.temperatura,
    required this.temperatura2,
    required this.temperatura_cpu,
    required this.umidade,
    required this.umidade2,
    required this.pressao,
  });

  Map<String,dynamic>toMap(){
    return{
      // 'id'       : id,
      'co'       : co,
      'data' : data,
      'temperatura'     : temperatura,
      'temperatura2'     : temperatura2,
      'temperatura_cpu'     : temperatura_cpu,
      'umidade'     : umidade,
      'umidade2'     : umidade2,
      'pressao'     : pressao,
    };
  }

  factory JsonObject.fromMap(Map<String,dynamic>map){
    return JsonObject(
      // id        : map['id']??'',
      co        : map['co']??'',
      data      : map['data']?? '',
      umidade       : map['umidade']?? '',
      umidade2      : map['umidade2']??'',
      temperatura   : map['temperatura']?? '',
      temperatura2   : map['temperatura2']?? '',
      temperatura_cpu   : map['temperatura_cpu']?? '',
      pressao         : map['pressao']?? '',
      );
  }

  String toJson()=>json.encode(toMap());
  
  factory JsonObject.fromJson(String source)=>JsonObject.fromMap(json.decode(source));
}