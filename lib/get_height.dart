import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:mud_safety/get_gps.dart';
import 'package:flutter_barometer/flutter_barometer.dart';

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

  Future<dynamic> getPressure() async {
    dynamic a = flutterBarometerEvents.single;
    return a;
  }

  Future<double> getHeight() async {

  }
}