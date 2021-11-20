import 'package:globo_fitness/helpers/weather_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpHelper {
  // http://api.openweathermap.org/data/2.5/weather?q=Eldoret&appid=2d3f8fb0aea803218ad3b9f703575f9c

  final String authority = 'api.openweathermap.org';
  final String path = 'data/2.5/weather';
  final String apiKey = '2d3f8fb0aea803218ad3b9f703575f9c';

  Future<Weather> getWeather(String location) async {
    Map<String, dynamic> parameters = {'q': location, 'appId': apiKey};
    Uri uri = Uri.https(authority, path, parameters);

    http.Response result = await http.get(uri);
    Map<String, dynamic> data = json.decode(result.body);

    Weather weather = Weather.fromJson(data);

    return weather;
  }
}
