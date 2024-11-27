import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_weather/src/model/weather.model.dart';

class WeatherServices {
  final String apiKey = "e6ba993d7dbdba649ae8eb0b8f1dc2bf";

  Future<WeatherData?> fetchWeather(double latitude, double longitude) async {
    final url =
        "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return WeatherData.fromJson(json);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}