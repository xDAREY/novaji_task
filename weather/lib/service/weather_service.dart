import 'dart:convert';

import 'package:http/http.dart' as http;

class WeatherService{
  final String _baseUrl = 'https://api.api-ninjas.com/v1/weather';
  static const String _apiKey = 'PfBbyPq+0t9HmcW8uppQ2w==qbn7gXVVaLFMOPRP';


  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final url = Uri.parse('$_baseUrl?city=$city');
    final response = await http.get(
      url,
      headers: {
        'X-Api-Key': _apiKey,
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}