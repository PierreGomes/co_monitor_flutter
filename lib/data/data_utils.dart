import 'package:charts_flutter/flutter.dart';
// import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'series.model.dart';
import '../api/api.implementation.dart';
import '../api/objects/json.object.dart';

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
  static Future<List<charts.Series<Serie, DateTime>>> getSeriesFromApi() async {
    List<JsonObject> list = await new Api().getJsonData();
    List<Serie> data = [];

    for(int i=0; i < list.length; i++){
      var dthr = DateTime.parse(list[i].Datetime);
      double yValue = double.parse(list[i].CO);
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

