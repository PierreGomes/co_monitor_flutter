import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:charts_flutter/flutter.dart' as charts;

// import 'donut_chart.dart';
import './line.chart.dart';
import '../data/series.model.dart';
import '../data/data_utils.dart';
import '../api/callApi.dart';
// import '../api/data_utils.dart';


class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState(Data.getSeries());
}

class _AppState extends State<App> with TickerProviderStateMixin, Data{
  var date = Data();
  late TabController _tabController;
  List<charts.Series<Serie, DateTime>> seriesList;

  DateTime _selected_date_inicio = DateTime.now();
  DateTime _selected_date_fim = DateTime.now();

  bool loading =false;

  _AppState(this.seriesList);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    Data.getSeriesFromApi().then((value) => seriesList = value);
  }

  void _refresh(){
    Data.getSeriesFromApi().then((value) => {
      // debugPrint(value.toString())
      setState(()=>{seriesList = value, loading = false})
    });
    // setState(() {
    //   Data.getSeriesFromApi().then((value) => seriesList = value);
    // });
  }

  Future<void> _selectDate(BuildContext context) async {
    // pega data inicial
    final DateTime? picked_inicio = await showDatePicker(
        context: context,
        initialDate: _selected_date_inicio,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101),
        helpText: "Inicio",
    );

    if (picked_inicio != null && picked_inicio != _selected_date_inicio) {
        _selected_date_inicio = picked_inicio;

        // pega data final
        final DateTime? picked_fim = await showDatePicker(
                context: context,
                initialDate: _selected_date_fim,
                firstDate: DateTime(2015, 8),
                lastDate: DateTime(2101),
                helpText: "Fim",
        );

        if (picked_fim != null && picked_fim != _selected_date_inicio) {
          _selected_date_fim = picked_fim;

          // atualiza as datas
          setState(() {
            loading = true;

            _selected_date_inicio = picked_inicio;
            _selected_date_fim = picked_fim;

            _refresh();

          });
        }
    }
  }


  @override
  Widget build(BuildContext context) {
    
    // debugPrint(pieChartData[0].toString());
    return Scaffold(
      appBar: AppBar(
        title: Text('Dados Coletados'),
        bottom: TabBar(controller: _tabController, tabs: [
          Tab(icon: Icon(FontAwesomeIcons.chartLine)),
          Tab(icon: Icon(FontAwesomeIcons.chartBar))
        ]),
        actions: [
          IconButton(onPressed: _refresh, icon: Icon(Icons.refresh))
        ],
      ),
      body: TabBarView(controller: _tabController, children: [
        // TextButton(onPressed: _refresh, child: Text('Refresh')),
        Stack(
          children:<Widget> [
            if(loading)
              Center(child: CircularProgressIndicator()),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: lineChart(seriesList),
            ),
          ],
        ),
        Container(
          color: Colors.grey,
          child: ApiTesting(result: ''),
        )
      ]),
      floatingActionButton: FloatingActionButton(onPressed: () {_selectDate(context);}, child: Icon(Icons.date_range)),
    );
  }
}
