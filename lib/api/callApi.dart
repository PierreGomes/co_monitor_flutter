import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../api/api.implementation.dart';
import '../api/objects/json.object.dart';

class ApiTesting extends StatefulWidget {
  ApiTesting({Key? key, required this.result}) : super(key: key);

  String result = '';
  
  @override
  void initState() {
    this.result = 'Sem Dados';
  }

  @override
  State<ApiTesting> createState() => _ApiTestingState();
}

class _ApiTestingState extends State<ApiTesting> {
  late List<JsonObject> list;

  void callApi() async {
    list = await new Api().getJsonData();

    setState(() => {
      widget.result = list[0].Datetime
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(onPressed: callApi, child: Text('Call Api')),
        Expanded(
          child: Container(
            color: Colors.amber,
            // mainAxisAlignment: MainAxisAlignment.center,
            child: Text(widget.result)
          ),
        ),
      ],
    );
  }


}

