import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';


// weather service는 getWeather(Weather 객체 반환), getCurrentCity(cityName반환) 이 두가지 메소드를 갖고 있음.
class WeatherService {
  //멤버션수 선언
  static const BASE_URL = 'http://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  //Weather객체를 얻기위한 (날씨정보가 아닌 Weather객체까지만) 메소드
  Future<Weather> getWeather(String cityName) async {
    //Dart의 http 패키지에서 제공하는 함수로, HTTP GET 요청을 보내는 데 사용됩니다. 이 메소드는 URL을 인자로 받아 서버에 데이터를 요청하고, 응답을 반환합니다.
    //HTTP 요청과 같은 네트워크 작업에서 URL은 Uri 객체의 형태로 사용되어야 합니다. Uri.parse는 문자열 형태의 URL을 이러한 Uri 객체로 변환하는 데 필요합니다.

    //var url = Uri.parse('https://api.weatherapi.com/v1/current.json?key=YOUR_API_KEY&query=Seoul');
    //var response = await http.get(url);


    final url = Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric');
    final response = await http
        .get(url);

    if (response.statusCode == 200) {
      //jsonDecode와 같은 함수를 사용하여 JSON 문자열을 Dart의 객체로 변환합니다
      return Weather.fromJdon(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Weather');
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    String? city = placemarks[0].name;
    print(placemarks.toString());

    return city ?? '';
  }
}


//ex) https://api.openweathermap.org/data/2.5/weather?q=seoul&appid=e484a1cfc701e7bec0db171c71cc4ce7&units=metric