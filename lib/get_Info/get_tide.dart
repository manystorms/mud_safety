import 'package:flutter/material.dart';
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
    if(Data.location_State != 'Enabled') {
      Data.obs_Graph_name = '위치 권한이 허용되지 않았습니다';
      return;
    }

    final request = Uri.parse(getTideURL(Data.latitude, Data.longitude, Data.TodayDate));
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
        final obsTime = data.findElements('obs_time').single.text;
        final obsLevel = data.findElements('obs_level').single.text;

        final obsDateTime = DateTime.parse(obsTime);
        final obsUnixTime = obsDateTime.millisecondsSinceEpoch/1000;

        Data.obs_x.add(obsUnixTime.toInt());
        Data.obs_y.add(double.parse(obsLevel));
      }
      await updateNextDayTide();
      updateTideGraphData();
    }else{
      Data.obs_Graph_name = '데이터를 받아오고 있습니다';
    }
  }

  Future<void> updateNextDayTide() async {
    final request = Uri.parse(getTideURL(Data.latitude, Data.longitude, Data.NextDayDate));
    final response = await http.get(request);

    if(response.body.contains('No search data')) {
      Data.obs_Graph_name = '갯벌에 있는지 확인해 주십시오';
    }else if (response.statusCode == 200) {
      final document = xml.XmlDocument.parse(response.body);
      final dataList = document.findAllElements('data');

      for (var data in dataList) {
        final obsTime = data.findElements('obs_time').single.text;
        final obsLevel = data.findElements('obs_level').single.text;

        final obsDateTime = DateTime.parse(obsTime);
        final obsUnixTime = obsDateTime.millisecondsSinceEpoch/1000;

        Data.obs_x.add(obsUnixTime.toInt());
        Data.obs_y.add(double.parse(obsLevel));
      }
    }else{
      Data.obs_Graph_name = '데이터를 받아오고 있습니다';
    }
  }

  void updateTideGraphData() {
    int StartTime = getUnixTime(); //UnixTime 기준
    int EndTime = StartTime+3600*12;
    Data.obs_Graph_x.clear();
    Data.obs_Graph_y.clear();

    for(int i = 0; i < Data.obs_x.length; i++) {
      if(Data.obs_x[i] >= StartTime && Data.obs_x[i] <= EndTime) {
        Data.obs_Graph_x.add(Data.obs_x[i]);
        Data.obs_Graph_y.add(Data.obs_y[i]);
      }
    }
  }

  Future<MaximumMinimumTideData> getMaximumMinimumTide(DateTimeRange SelectedDate) async {
    int Date = 0;
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
      DateTime MaximumTideTime;
      double MinimumTideVal = 1000;
      DateTime MinimumTideTime;

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
      //res.MaximumTime = MaximumTideTime.toString();
    }

    return res;
  }
}

class MaximumMinimumTideData {
  String MaximumTideVal = 'xx(m)';
  String MaximumTime = '--:--am';

  String MinimumTideVal = 'xx(m)';
  String MinimumTime = '--:--am';
}