import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  // ignore: constant_identifier_names
  static const BASE_URL = "http://api.weatherapi.com/v1/current.json";
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityPosition) async {
    final response = await http.get(Uri.parse(
        '$BASE_URL?key=0f90e5961c5e48c2b05185043242307&q=$cityPosition'));
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Falha ao Carregar, tente novamente mais tarde");
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    //fetch the current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);

    String? city = '${position.latitude},${position.longitude}';

    return city;
  }
}
