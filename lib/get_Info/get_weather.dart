import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:mud_safety/get_Info/get_gps.dart';
import 'dart:async';

class WeatherReveive {
  String getWeatherURL(double? latitude, double? longitude) {
    const URL1 = 'https://api.openweathermap.org/data/2.5/weather?lat=';
    const URL2 = '&lon=';
    const URL3 = '&appid=';
    const URL4 = '&mode=xml';
    const APIkey = '8916a3737079c421e07f366d6b44b754';

    return URL1+latitude.toString()+URL2+longitude.toString()+URL3+APIkey+URL4;
  }

  Future<(double, double, int)> getWeather() async {
    GpsReceive gpsReceive = GpsReceive();
    var gpsLocation = await gpsReceive.getLocation();

    final request = Uri.parse(getWeatherURL(gpsLocation.$1, gpsLocation.$2));
    final response = await http.get(request);
    double Pressure = 0;
    double Temperature = 0;
    int Error = 1;

    if(response.statusCode == 200) {
      Error = 0;
      final document = xml.XmlDocument.parse(response.body);

      String? temperature = document.findAllElements('temperature').first.getAttribute('value');
      if(temperature != null) Temperature = double.parse(temperature);

      // pressure의 value 추출
      String? pressure = document.findAllElements('pressure').first.getAttribute('value');
      if(pressure != null) Pressure = double.parse(pressure);

    }
    return (Pressure, Temperature, Error);
  }
}
