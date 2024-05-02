import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:mud_safety/get_gps.dart';
import 'package:sensor_library/models/raw_sensors/barometer.dart';
import 'dart:async';
import 'dart:math';

class HeightReveive {
  String getWeatherURL(double? latitude, double? longitude) {
    const URL1 = 'https://api.openweathermap.org/data/2.5/weather?lat=';
    const URL2 = '&lon=';
    const URL3 = '&appid=';
    const URL4 = '&mode=xml';
    const APIkey = '8916a3737079c421e07f366d6b44b754';

    return URL1+latitude.toString()+URL2+longitude.toString()+URL3+APIkey+URL4;
  }

  Future<Map<String, double>> getWeather() async {
    GpsReceive gpsReceive = GpsReceive();
    Map<String, double> gpslocation = await gpsReceive.getLocation();

    final request = Uri.parse(getWeatherURL(gpslocation['latitude'], gpslocation['longitude']));
    final response = await http.get(request);

    if(response.statusCode == 200) {
      Map<String, double> res = {'Error': 0};
      final document = xml.XmlDocument.parse(response.body);

      String? temperature = document.findAllElements('temperature').first.getAttribute('value');
      if(temperature != null) res['temperature'] = double.parse(temperature);

      // pressure의 value 추출
      String? pressure = document.findAllElements('pressure').first.getAttribute('value');
      if(pressure != null) res['pressure'] = double.parse(pressure);

      return res;
    }else{
      return {'Error': 1};
    }
  }

  Future<void> getPressure() async {
    Completer<void> completer = Completer<void>();

    late Barometer barometer;
    barometer = Barometer(inMillis: 1000);

    // 기압 데이터 수신 이벤트 구독
    barometer.getRaw().listen((element) {
      double valueInHectopascal = element.hectpascal;
      print(valueInHectopascal);
      print('b');
      completer.complete(); // 기압 데이터를 가져왔으므로 Future를 완료합니다.
    });
    print('c');
    // 비동기 작업 완료 대기
    await completer.future;
    print('a');
  }

  Future<double> getHeight() {
    double res = 0;
    double WeatherPressure = 0;
    double WeatherTemperature = 0;
    double Pressure = 0;
    const R = 297.0;
    const G = 9.8;

    res = R*WeatherTemperature/G*log(WeatherPressure/Pressure);

    return res; //m
  }
}
