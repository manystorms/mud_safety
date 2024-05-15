import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:mud_safety/get_gps.dart';

class TideReceive {
  String getTideURL(double? latitude, double? longitude, int Date) {
    const URL1 = 'http://www.khoa.go.kr/api/oceangrid/tideBedPre/search.do?ServiceKey=';
    const URL2 = '&Date=';
    const URL3 = '&ObsLon=';
    const URL4 = '&ObsLat=';
    const URL5 = '&ResultType=xml';
    const APIkey = 'TMDcRQm7z6SwG84o2lOWA==';

    return URL1+APIkey+URL2+Date.toString()+URL3+longitude.toString()+URL4+latitude.toString()+URL5;
  }

  Future<Map<String, double>> getTide() async {
    GpsReceive gpsReceive = GpsReceive();
    var gpsLocation = await gpsReceive.getLocation();

    final request = Uri.parse(getTideURL(gpsLocation.$1, gpsLocation.$2, 20240430));
    final response = await http.get(request);

    if(response.body.contains('No search data')) {
      return {'Error': 1.5};
    }else if (response.statusCode == 200) {
      final document = xml.XmlDocument.parse(response.body);
      final dataList = document.findAllElements('data');
      final Map<String, double> obsMap = {};

      for (var data in dataList) {
        final obsTime = data.findElements('obs_time').single.text;
        final obsLevel = data.findElements('obs_level').single.text;

        obsMap[obsTime] = double.parse(obsLevel);
      }
      return obsMap;
    }else{
      return {'Error': 1};
    }
  }

}