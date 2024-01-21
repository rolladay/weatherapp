class Weather {
  String cityName;
  double temperature;
  String mainCondition;

  Weather(
      {required this.cityName,
      required this.temperature,
      required this.mainCondition});

  // factory COnstructor 예시. Weather.fromJdon이 factory생성자 이름이고, 얘가 json2 라는 Map데이터를 받아서 Weather라는
  //갹체를 리턴하는 것이 이 팩토리 생성자의 역할인 듯
  factory Weather.fromJdon(Map<String, dynamic> json2){
    return Weather(
      cityName: json2['name'],
      temperature: json2['main']['temp'].toDouble(),
      mainCondition: json2['weather'][0]['main']
    );
  }
}

//Weather모델이라는 것은 Weather라는 객체의 생김새를 정의하는 것?
