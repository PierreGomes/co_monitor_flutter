import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/data_utils.dart';
import '../data/series.model.dart';

class lineChart extends StatelessWidget {
  final List<charts.Series<Serie, DateTime>> seriesList;

  lineChart(this.seriesList);

  factory lineChart.withSampleData(List<charts.Series<Serie, DateTime>> seriesList) {
    return new lineChart(
      seriesList
    );
  }


  @override
  Widget build(BuildContext context) {

    final simpleCurrencyFormatter = new charts.BasicNumericTickFormatterSpec.fromNumberFormat(
            new NumberFormat.compactSimpleCurrency()
    );

    return new charts.TimeSeriesChart(
        seriesList,
        animate: true,
        /*
        * Formata DTHR no X axis
        */
        domainAxis: new charts.DateTimeAxisSpec(
            tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(
                day: new charts.TimeFormatterSpec(
                    format: 'd', transitionFormat: 'MM/dd/yyyy'
                )
            )
        )
    );
  }
}