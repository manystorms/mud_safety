import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:mud_safety/get_Info/get_data.dart';
import 'package:mud_safety/date/date_observatory_list.dart';
import 'dart:convert';
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
    if(Data.location_State != 'Enabled') return;

    getWeatherPressure();

    final request = Uri.parse(getWeatherURL(Data.latitude, Data.longitude));
    final response = await http.get(request);

    if(response.statusCode == 200) {
      final document = xml.XmlDocument.parse(response.body);

      String? temperature = document.findAllElements('temperature').first.getAttribute('value');
      if(temperature != null) Data.Weather_Temperature = double.parse(temperature);

      // pressure의 value 추출
      String? pressure = document.findAllElements('pressure').first.getAttribute('value');
      //if(pressure != null) Data.Weather_Pressure = double.parse(pressure);

      String? humidity = document.findAllElements('humidity').first.getAttribute('value');
      if(humidity != null) Data.Weather_Humidity = double.parse(humidity);

      Data.Weather_Error = 0;
    }else{
      Data.Weather_Error = 1;
    }
  }

  String getPressureURL() {
    Observatory_list Obs = Observatory_list();

    String ObsCode = Obs.NearestObsCode(Data.latitude, Data.longitude);
    String Date = getToday();

    const URL1 = 'http://www.khoa.go.kr/api/oceangrid/tideObsAirPres/search.do?ServiceKey=';
    const URL2 = '&ObsCode=';
    const URL3 = '&Date=';
    const URL4 = '&ResultType=json';
    const APIkey = 'TMDcRQm7z6SwG84o2lOWA==';

    return URL1+APIkey+URL2+ObsCode+URL3+Date+URL4;
  }

  Future<void> getWeatherPressure() async {
    final request = Uri.parse(getPressureURL());
    final response = await http.get(request);

    DateTime now = DateTime.now();

    if(response.statusCode == 200) {
      /*Map<String, dynamic> jsonMap = jsonDecode(response.body);

      List<dynamic> data = jsonMap['result']['data'];

      for (var item in data) {
        DateTime recordTime = DateTime.parse(item['record_time']);
        if (recordTime.isAfter(now)) {
          Data.Pressure =  item['air_pres'];
          print(recordTime);
        }
      }*/

      Data.Weather_Pressure_Error = 0;
      print(response.body);
      print(Data.Pressure);
    }else{
      Data.Weather_Pressure_Error = 1;
    }
  }
}
