import 'dart:developer';

import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gauges/gauges.dart';

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
  String filtro = 'co';

  _AppState(this.seriesList);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 1,
      vsync: this,
    );

    if(loading){
      Data.getSeriesFromApi(
        _selected_date_inicio.toString()?? "2022-06-29",
        _selected_date_fim.toString()?? "2022-06-29",
        filtro ?? "co"
      ).then(
        // atualiza os dados do estado
        (value){
          setState((){
            log(value.toString());
            loading = false;
            seriesList = value!;
          });
        }
      );
    }
  }

  void _refresh(){
    
    debugPrint(_selected_date_inicio.toString() + _selected_date_fim.toString());

    Data.getSeriesFromApi(
      _selected_date_inicio.toString()?? "2022-06-29",
      _selected_date_fim.toString()?? "2022-06-29",
      filtro
    ).then((value) => {
      // debugPrint(value.toString())
      setState(()=>{seriesList = value!, loading = false})
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

    debugPrint("ok");

    if (picked_inicio != null) {
        _selected_date_inicio = picked_inicio;

        // pega data final
        final DateTime? picked_fim = await showDatePicker(
                context: context,
                initialDate: _selected_date_fim,
                firstDate: DateTime(2015, 8),
                lastDate: DateTime(2101),
                helpText: "Fim",
        );

        if (picked_fim != null) {
          _selected_date_fim = picked_fim;
          debugPrint("ok 2");
          // atualiza as datas
          setState(() {
            loading = true;

            _selected_date_inicio = picked_inicio;
            _selected_date_fim = picked_fim;

            // _refresh();

          });
        }
          debugPrint("ok 3");

    }
  }


  @override
  Widget build(BuildContext context) {

    if(loading){
      Data.getSeriesFromApi(
        _selected_date_inicio.toString()?? "2022-06-29",
        _selected_date_fim.toString()?? "2022-06-29",
        filtro ?? "co"
      ).then(
        // atualiza os dados do estado
        (value){
          setState((){
            log(value.toString());
            loading = false;

            if(value == null){
              debugPrint("Sem dados para plotar");
              Fluttertoast.showToast(
                msg: "Nenhum dado encontrada",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.TOP_RIGHT,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
              );
              return;
            }

            seriesList = value!;
          });
        }
      );
    }
    
    // debugPrint(pieChartData[0].toString());
    return Scaffold(
      appBar: AppBar(
        // title: Text('Dados Coletados'),
        title:  new DropdownButton<String>(
          value: filtro,
          items: <DropdownMenuItem<String>>[
            new DropdownMenuItem(
              child: new Text('co'),
              value: 'co',
            ),
            new DropdownMenuItem(
              child: new Text('umidade'),
              value: 'umidade'
            ),
            new DropdownMenuItem(
              child: new Text('umidade2'),
              value: 'umidade2'
            ),
            new DropdownMenuItem(
              child: new Text('pressao'),
              value: 'pressao'
            ),
            new DropdownMenuItem(
              child: new Text('temperatura'),
              value: 'temperatura'
            ),
            new DropdownMenuItem(
              child: new Text('temperatura2'),
              value: 'temperatura2'
            ),
            new DropdownMenuItem(
              child: new Text('temperatura_cpu'),
              value: 'temperatura_cpu'
            ),
          ], 
          onChanged: (String? value) {
            setState(() => filtro = value?? "");
            _refresh();
          },
        ),
        bottom: TabBar(controller: _tabController, tabs: [
          Tab(icon: Icon(FontAwesomeIcons.chartLine)),
        ]),
        actions: [
          IconButton(
            onPressed: _refresh,
            icon: Icon(Icons.refresh)
          )
        ],
      ),
      // Grafíco
      body: TabBarView(
        controller: _tabController,
        children: [
          Stack(
            children:<Widget> [
              // loading
              if(loading)
                Center(child: CircularProgressIndicator()),
              // chart
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: lineChart(seriesList),
              ),
            ],
          ),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {_selectDate(context);},
        child: Icon(Icons.date_range)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
    );
  }
}
