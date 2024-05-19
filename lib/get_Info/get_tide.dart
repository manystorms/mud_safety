import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:mud_safety/get_Info/get_data.dart';

class TideReceive {
  String getTideURL(double latitude, double longitude, String Date) {
    const URL1 = 'http://www.khoa.go.kr/api/oceangrid/tideBedPre/search.do?ServiceKey=';
    const URL2 = '&Date=';
    const URL3 = '&ObsLon=';
    const URL4 = '&ObsLat=';
    const URL5 = '&ResultType=xml';
    const APIkey = 'TMDcRQm7z6SwG84o2lOWA==';

    return URL1+APIkey+URL2+Date+URL3+longitude.toString()+URL4+latitude.toString()+URL5;
  }

  Future<ObsData> updateTide() async {
    ObsData res = ObsData();

    if(Data.location_State != 'Enabled') {
      res.obsState = '위치 권한이 허용되지 않았습니다';
      return res;
    }

    final request = Uri.parse(getTideURL(Data.latitude, Data.longitude, getToday()));
    final response = await http.get(request);

    if(response.body.contains('No search data')) {
      res.obsState = '갯벌에 있는지 확인해 주십시오';
    }else if (response.statusCode == 200) {
      final document = xml.XmlDocument.parse(response.body);
      final dataList = document.findAllElements('data');

      res.obsState = '시간별 조위';
      res.obs_x.clear();
      res.obs_y.clear();

      for (var data in dataList) {
        final obsTime = data.findElements('obs_time').single.text;
        final obsLevel = data.findElements('obs_level').single.text;

        final obsDateTime = DateTime.parse(obsTime);
        final obsUnixTime = obsDateTime.millisecondsSinceEpoch/1000;

        res.obs_x.add(obsUnixTime.toInt());
        res.obs_y.add(double.parse(obsLevel));
      }
    }else{
      res.obsState = '데이터를 받아오고 있습니다';
    }
    return res;
  }

  ObsGraphData updateTideGraphData(ObsData inputData) {
    ObsGraphData res = ObsGraphData();
    int StartTime = getUnixTime(); //UnixTime 기준
    int EndTime = StartTime+3600*12;
    res.obs_Graph_x.clear();
    res.obs_Graph_y.clear();
    res.obsGraphName = inputData.obsState;

    for(int i = 0; i < inputData.obs_x.length; i++) {
      if(inputData.obs_x[i] >= StartTime && inputData.obs_x[i] <= EndTime) {
        res.obs_Graph_x.add(inputData.obs_x[i]);
        res.obs_Graph_y.add(inputData.obs_y[i]);
      }
    }
    return res;
  }

  Future<MaximumMinimumTideData> getMaximumMinimumTide(DateTimeRange SelectedDate) async {
    DateTime startDate = SelectedDate.start;
    String Date = "${startDate.year.toString().padLeft(4, '0')}"
        "${startDate.month.toString().padLeft(2, '0')}${startDate.day.toString().padLeft(2, '0')}";
    print(Date);
    MaximumMinimumTideData res = MaximumMinimumTideData();

    if(Data.location_State != 'Enabled') {
      res.MaximumTideVal = '위치 권한이 허용되지 않았습니다';
      res.MinimumTideVal = '위치 권한이 허용되지 않았습니다';
      res.MaximumTime = '--:--am';
      res.MinimumTime = '--:--am';
    }

    final request = Uri.parse(getTideURL(Data.latitude, Data.longitude, Date));
    final response = await http.get(request);

    if(response.body.contains('No search data')) {
      res.MaximumTideVal = '갯벌에 있는지 확인해 주세요';
      res.MinimumTideVal = '갯벌에 있는지 확인해 주세요';
      res.MaximumTime = '--:--am';
      res.MinimumTime = '--:--am';
    }else if (response.statusCode == 200) {
      final document = xml.XmlDocument.parse(response.body);
      final dataList = document.findAllElements('data');

      double MaximumTideVal = -1000;
      DateTime MaximumTideTime = DateTime(2024, 5, 19, 12);
      double MinimumTideVal = 1000;
      DateTime MinimumTideTime = DateTime(2023, 5, 19, 12);

      int NowUnixTime = getUnixTime();

      for (var data in dataList) {
        final obsTime = data.findElements('obs_time').single.text;
        final obsLevel = data.findElements('obs_level').single.text;

        final obsDateTime = DateTime.parse(obsTime);
        final obsUnixTime = obsDateTime.millisecondsSinceEpoch/1000;

        if(obsUnixTime < NowUnixTime) continue;

        if(double.parse(obsLevel) > MaximumTideVal) {
          MaximumTideVal = double.parse(obsLevel);
          MaximumTideTime = obsDateTime;
        }

        if(double.parse(obsLevel) < MinimumTideVal) {
          MinimumTideVal = double.parse(obsLevel);
          MinimumTideTime = obsDateTime;
        }
      }

      res.MaximumTideVal = (MaximumTideVal/100).toString()+'(m)';
      res.MinimumTideVal = (MinimumTideVal/100).toString()+'(m)';

      int MaximumTideHour = MaximumTideTime.hour;
      int MaximumTideMin = MaximumTideTime.minute;
      String MaximumTideAmPm = 'am';
      if(MaximumTideHour >= 12) {
        MaximumTideHour -= 12; MaximumTideAmPm = 'pm';
      }

      int MinimumTideHour = MinimumTideTime.hour;
      int MinimumTideMin = MinimumTideTime.minute;
      String MinimumTideAmPm = 'am';
      if(MinimumTideHour >= 12) {
        MinimumTideHour -= 12; MinimumTideAmPm = 'pm';
      }

      res.MaximumTime = MaximumTideHour.toString()+':'+MaximumTideMin.toString()+MaximumTideAmPm;
      res.MinimumTime = MinimumTideHour.toString()+':'+MinimumTideMin.toString()+MinimumTideAmPm;
    }

    return res;
  }
}

class ObsData {
  String obsState = '데이터를 받아오고 있습니다';
  List<int> obs_x = [0];
  List<double> obs_y = [0];
}

class ObsGraphData {
  String obsGraphName = '데이터를 받아오고 있습니다';
  List<int> obs_Graph_x = [0];
  List<double> obs_Graph_y = [0];
}

class MaximumMinimumTideData {
  String MaximumTideVal = 'xx(m)';
  String MaximumTime = '--:--am';

  String MinimumTideVal = 'xx(m)';
  String MinimumTime = '--:--am';
}