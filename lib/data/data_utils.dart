import 'package:charts_flutter/flutter.dart';
// import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'series.model.dart';
import '../api/api.implementation2.dart';
import '../api/objects/json.object2.dart';

class Data {
  // Dados Fake Exemplo
  static List<charts.Series<Serie, DateTime>> getSeries() {
    final data = [
      new Serie(new DateTime(2017, 9, 25), 6.22),
      new Serie(new DateTime(2017, 9, 26), 8),
      new Serie(new DateTime(2017, 9, 27), 6),
      new Serie(new DateTime(2017, 9, 28), 9.221),
      new Serie(new DateTime(2017, 9, 29), 11),
      new Serie(new DateTime(2017, 9, 30), 15),
      new Serie(new DateTime(2017, 10, 01), 25),
      new Serie(new DateTime(2017, 10, 02), 33.22),
      new Serie(new DateTime(2017, 10, 03), 27),
      new Serie(new DateTime(2017, 10, 04), 31.375),
      new Serie(new DateTime(2017, 10, 05), 23),
    ];

    return [
      new charts.Series<Serie, DateTime>(
        id: 'Cost',
        domainFn: (Serie row, _) => row.timeStamp,
        measureFn: (Serie row, _) => row.cost,
        data: data,
      )
    ];
  }

  // Busca da Api
  static Future<List<charts.Series<Serie, DateTime>>> getSeriesFromApi(String dtInicio, String dtFinal, String filtro) async {
    List<JsonObject> list = await new Api_2().getJsonData(dtInicio, dtFinal);
    List<Serie> data = [];

    debugPrint(filtro);

    for(int i=0; i < list.length; i++){
      var dthr = DateTime.parse(list[i].data);

      double yValue = -1;

      try{
        switch(filtro){
          case 'co':
            yValue = double.parse(list[i].co);
            break;
          case 'umidade':
            yValue = double.parse(list[i].umidade);
            break;  
          case 'pressao':
            yValue = double.parse(list[i].pressao);
            break;  
          case 'temperatura':
            yValue = double.parse(list[i].temperatura);
            break;
          case 'temperatura2':
            yValue = double.parse(list[i].temperatura2);
            break;
          case 'umidade2':
            yValue = double.parse(list[i].umidade2);
            break;
          case 'temperatura_cpu':
            yValue = double.parse(list[i].temperatura_cpu);
            break;  
      
        }

        // yValue = double.parse(list[i].CO);
      } catch(e) {}
      
      debugPrint("dthr: " + dthr.toString() + "\n y =" + yValue.toString());
      data.add(
        new Serie( dthr, yValue)
      );
    }



    // final data = [
    //   // new Serie(new DateTime(2017, 9, 25), 6.22),
    //   // new Serie(new DateTime(2017, 9, 26), 8),
    //   // new Serie(new DateTime(2017, 9, 27), 6),
    //   // new Serie(new DateTime(2017, 9, 28), 9.221),
    //   // new Serie(new DateTime(2017, 9, 29), 11),
    //   // new Serie(new DateTime(2017, 9, 30), 15),
    //   // new Serie(new DateTime(2017, 10, 01), 25),
    //   // new Serie(new DateTime(2017, 10, 02), 33.22),
    //   // new Serie(new DateTime(2017, 10, 03), 27),
    //   // new Serie(new DateTime(2017, 10, 04), 31.375),
    //   // new Serie(new DateTime(2017, 10, 05), 23),
    // ];



    return [
      new charts.Series<Serie, DateTime>(
        id: 'Cost',
        domainFn: (Serie row, _) => row.timeStamp,
        measureFn: (Serie row, _) => row.cost,
        data: data,
      )
    ];
  }
}

