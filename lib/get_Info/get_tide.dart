import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:mud_safety/get_Info/get_data.dart';

class TideReceive {
  String getTideURL(double latitude, double longitude, int Date) {
    const URL1 = 'http://www.khoa.go.kr/api/oceangrid/tideBedPre/search.do?ServiceKey=';
    const URL2 = '&Date=';
    const URL3 = '&ObsLon=';
    const URL4 = '&ObsLat=';
    const URL5 = '&ResultType=xml';
    const APIkey = 'TMDcRQm7z6SwG84o2lOWA==';

    return URL1+APIkey+URL2+Date.toString()+URL3+longitude.toString()+URL4+latitude.toString()+URL5;
  }

  Future<void> updateTide() async {
    final request = Uri.parse(getTideURL(Data.latitude, Data.longitude, 20240430));
    final response = await http.get(request);

    if(response.body.contains('No search data')) {
      Data.obs_Graph_name = '갯벌에 있는지 확인해 주십시오';
    }else if (response.statusCode == 200) {
      final document = xml.XmlDocument.parse(response.body);
      final dataList = document.findAllElements('data');

      Data.obs_Graph_name = '시간별 조위';
      Data.obs_x.clear();
      Data.obs_y.clear();

      for (var data in dataList) {
        final obsTime = data.findElements('obs_time').single;
        final obsLevel = data.findElements('obs_level').single;

        Data.obs_x.add(obsTime);
        Data.obs_y.add(obsLevel);
      }
    }else{
      Data.obs_Graph_name = '데이터를 받아오고 있습니다';
    }
  }

  Future<MaximumMinimumTideData> getMaximumMinimumTide(int Date) async {
    final request = Uri.parse(getTideURL(Data.latitude, Data.longitude, Date));
    final response = await http.get(request);

    MaximumMinimumTideData res = MaximumMinimumTideData();

    return res;
  }
}

class MaximumMinimumTideData {
  double MaximumTideVal = 0;
  int MaximumTideMin = 0;
  int MaximumTideSec = 0;
  String MaximumAmPm = 'Loading';

  double MinimumTideVal = 0;
  int MinimumTideMin = 0;
  int MinimumTideSec = 0;
  String MinimumAmPm = 'Loading';
}