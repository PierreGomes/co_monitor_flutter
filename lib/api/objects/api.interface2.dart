import './json.object2.dart';

abstract class ApiInterface {

  Future<List<JsonObject>?> getJsonData(String dtIncio, String dtFinal);

}