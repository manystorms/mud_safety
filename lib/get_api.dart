import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiReceive {
  String getURL(double latitude, double longitude, int Date) {
    const URL1 = 'http://www.khoa.go.kr/api/oceangrid/tideBedPre/search.do?ServiceKey=';
    const URL2 = '&Date=';
    const URL3 = '&ObsLon=';
    const URL4 = '&ObsLat=';
    const URL5 = '&ResultType=json';
    const APIkey = 'TMDcRQm7z6SwG84o2lOWA==';

    return URL1+APIkey+URL2+Date.toString()+URL3+longitude.toString()+URL4+latitude.toString()+URL5;
  }

  Future<void> getTide() async {
    final request = Uri.parse(getURL(33.958, 128.3845, 20240430));
    http.Response response = await http.get(request);
    if(response.statusCode == 200) {
      String jsonString = response.body;
      Map<String, dynamic> jsonData = jsonDecode(jsonString);

      List<Map<String, dynamic>> data = jsonData['result']['data'];

      for (var entry in data) {
        String tideTime = entry['tide_time'];
        String tideLevel = entry['tide_level'];
        print('tide_time: $tideTime, tide_level: $tideLevel');
      }
    }
  }

}