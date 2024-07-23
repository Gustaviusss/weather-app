import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('b3b88fa80bc601a07c5f8d6d5d5f04d6');
  Weather? _weather;

  _fetchWeather() async {
    //get the city name
    String cityPosition = await _weatherService.getCurrentCity();

    //try to get the weather
    try {
      final weather = await _weatherService.getWeather(cityPosition);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  //weather animations
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition) {
      case 'Sunny':
      case 'Partly cloudy':
        return 'assets/sunny.json';

      case 'Cloudy':
      case 'Overcast':
      case 'Mist':
      case 'Fog':
      case 'Freezing fog':
        return 'assets/cloudy.json';

      case 'Patchy rain possible':
      case 'Patchy light drizzle':
      case 'Light drizzle':
      case 'Patchy light rain':
      case 'Light rain':
      case 'Moderate rain at times':
      case 'Moderate rain':
      case 'Heavy rain at times':
      case 'Heavy rain':
      case 'Patchy light rain with thunder':
      case 'Moderate or heavy rain with thunder':
      case 'Light rain shower':
      case 'Moderate or heavy rain shower':
      case 'Torrential rain shower':
      case 'Freezing drizzle':
      case 'Heavy freezing drizzle':
      case 'Light freezing rain':
      case 'Moderate or heavy freezing rain':
        return 'assets/rainy.json';

      case 'Thundery outbreaks possible':
      case 'Patchy snow possible':
      case 'Patchy sleet possible':
      case 'Patchy freezing drizzle possible':
      case 'Patchy light snow':
      case 'Light snow':
      case 'Patchy moderate snow':
      case 'Moderate snow':
      case 'Patchy heavy snow':
      case 'Heavy snow':
      case 'Blowing snow':
      case 'Blizzard':
      case 'Ice pellets':
      case 'Light sleet':
      case 'Moderate or heavy sleet':
      case 'Light sleet showers':
      case 'Moderate or heavy sleet showers':
      case 'Light showers of ice pellets':
      case 'Moderate or heavy showers of ice pellets':
      case 'Patchy light snow with thunder':
      case 'Moderate or heavy snow with thunder':
        return 'assets/thunder.json';

      default:
        return 'assets/sunny.json';
    }
  }

  //init state
  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.location_on,
                    size: 32,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    _weather?.cityName ?? 'CARREGANDO CIDADE',
                    style: const TextStyle(
                        fontFamily: "Bebas Neue",
                        fontSize: 32,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            Text('${_weather?.temperature.round()}°C',
                style: const TextStyle(
                    fontSize: 64,
                    color: Colors.white,
                    fontFamily: "Bebas Neue")),
          ],
        ),
      ),
    );
  }
}
