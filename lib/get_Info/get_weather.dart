import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:mud_safety/get_Info/get_gps.dart';
import 'package:mud_safety/get_Info/get_data.dart';
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

  Future<void> updateWeather() async {
    GpsReceive gpsReceive = GpsReceive();

    final request = Uri.parse(getWeatherURL(Data.latitude, Data.longitude));
    final response = await http.get(request);

    if(response.statusCode == 200) {
      final document = xml.XmlDocument.parse(response.body);

      String? temperature = document.findAllElements('temperature').first.getAttribute('value');
      if(temperature != null) Data.Weather_Temperature = double.parse(temperature);

      // pressure의 value 추출
      String? pressure = document.findAllElements('pressure').first.getAttribute('value');
      if(pressure != null) Data.Weather_Pressure = double.parse(pressure);

      Data.Weather_Error = 0;
    }else{
      Data.Weather_Error = 1;
    }
  }
}
