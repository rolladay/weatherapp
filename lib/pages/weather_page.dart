import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_weather/services/weather_service.dart';

import '../models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //apikey
  //WeatherPage 클래스는
  //Weather(nullable) 객체를 선언해서 갖고 있고 _weather
  // WeatherService 를 가지고 있다 (두개의 메소드. getWeather, currentCity)
  final _weatherService = WeatherService('e484a1cfc701e7bec0db171c71cc4ce7');
  Weather? _weather;

  //fetch weather - initState때 쓰이네
  _fetchWeather() async {
    // get current city
    String cityName = await _weatherService.getCurrentCity();
    print(cityName);

    //get weather for here
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        //weather는 json Data 인데.. 아닌가 Map Data인가? 아니다 fromJdon으로 Weather객체로 변환해서 반환했구나.
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  // WeatherService를 통해 weather객체에 있는
  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
        return 'assets/sunny.json';

      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchWeather();

  }

  //weather animation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //cityName
            Text(_weather?.cityName ?? 'City Name'),
            //animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            //temperature
            Text('${_weather?.temperature.round()}C' ?? 'Loading...'),
            //weather condition
            Text(_weather?.mainCondition ?? ''),
          ],
        ),
      ),
    );
  }
}
