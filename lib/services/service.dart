import 'dart:convert';
import 'package:apiapp/config.dart';
import 'package:apiapp/models/data.dart';
import 'package:http/http.dart' as http;

class DataService {
  static Future<Data?> getData() async {
    final response = await http.get(
      Uri.parse(Config.backendurl),
    );

    if (response.statusCode == 200) {
      return Data.fromJSON(jsonDecode(response.body));
    }
    return null;
  }

  static Future<List<Data>?> getDataall() async {
    final response = await http.get(Uri.parse(Config.backendurl));

    if (response.statusCode == 200) {
      return jsonDecode(response.body).map<Data>((data) {
        return Data.fromJSON(data);
      }).toList();
    }
    return null;
  }
}
