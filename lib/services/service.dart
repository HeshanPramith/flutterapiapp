import 'dart:convert';
import 'package:apiapp/config.dart';
import 'package:apiapp/models/data.dart';
import 'package:http/http.dart' as http;

class RocketService {
  static Future<Rocket?> getRocket() async {
    final response = await http.get(
      Uri.parse("${Config.backendurl}rockets/5e9d0d95eda69973a809d1ec"),
    );

    if (response.statusCode == 200) {
      return Rocket.fromJSON(jsonDecode(response.body));
    }
    return null;
  }

  static Future<List<Rocket>?> getRockets() async {
    final response = await http.get(Uri.parse("${Config.backendurl}rockets"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body).map<Rocket>((data) {
        return Rocket.fromJSON(data);
      }).toList();
    }
    return null;
  }
}
