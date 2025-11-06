import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  static const String _apiKey = 'a0930de91c3d480d979171500250511';
  static const String _baseUrl = 'https://api.weatherapi.com/v1';

  static Future<Weather> fetchWeather(String city) async {
    final url = '$_baseUrl/current.json?key=$_apiKey&q=$city&lang=ru';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Ошибка: ${response.statusCode}');
    }
  }
}
