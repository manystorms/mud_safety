import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mud_safety/get_gps.dart';

class ApiReceive {
  String getURL(double? latitude, double? longitude, int Date) {
    const URL1 = 'http://www.khoa.go.kr/api/oceangrid/tideBedPre/search.do?ServiceKey=';
    const URL2 = '&Date=';
    const URL3 = '&ObsLon=';
    const URL4 = '&ObsLat=';
    const URL5 = '&ResultType=json';
    const APIkey = 'TMDcRQm7z6SwG84o2lOWA==';

    return URL1+APIkey+URL2+Date.toString()+URL3+longitude.toString()+URL4+latitude.toString()+URL5;
  }

  Future<void> getTide() async {
    GpsReceive gpsReceive = GpsReceive();
    Map<String, double> gpslocation = await gpsReceive.getLocation();

    final request = Uri.parse(getURL(
        gpslocation['latitude'], gpslocation['longitude'], 20240430));
    http.Response response = await http.get(request);
    if(response.statusCode == 200) {
      String jsonString = response.body;
      Map<String, dynamic> jsonData = jsonDecode(jsonString);

      List<Map<String, dynamic>> dataList = (jsonData['data'] as List).cast<Map<String, dynamic>>();

      Map<String, String> tideMap = {};
      for (Map<String, dynamic>? item in dataList) {
        // 데이터 항목이 null이 아니면 처리합니다.
        if (item != null) {
          String tideTime = item['tide_time'];
          String tideLevel = item['tide_level'];

          // tideTime과 tideLevel이 모두 null이 아닌 경우에만 tideMap에 추가합니다.
          if (tideTime != null && tideLevel != null) {
            tideMap[tideTime] = tideLevel;
          }
        }
      }

      print(tideMap);
    }
  }

}