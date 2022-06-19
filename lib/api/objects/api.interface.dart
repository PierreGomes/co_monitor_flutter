import './json.object.dart';

abstract class ApiInterface {

  Future<List<JsonObject>> getJsonData();

}