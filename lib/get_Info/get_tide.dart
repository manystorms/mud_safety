import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:mud_safety/get_Info/get_data.dart';
import 'dart:convert';

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

  String getTideForecastURL(String Observatory, String Date) {
    const URL1 = 'http://www.khoa.go.kr/api/oceangrid/tideObsPreTab/search.do?ServiceKey=';
    const URL2 = '&ObsCode=';
    const URL3 = '&Date=';
    const URL4 = '&ResultType=json';
    const APIkey = 'TMDcRQm7z6SwG84o2lOWA==';

    return URL1+APIkey+URL2+Observatory+URL3+Date+URL4;
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
      res.obsState = '현재 위치의 데이터를 불러올 수 없습니다';
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

  Future<MaximumMinimumTideData> getMaximumMinimumTide(DateTimeRange SelectedDate, String ObsCode) async {
    DateTime startDate = SelectedDate.start;
    String Date = "${startDate.year.toString().padLeft(4, '0')}"
        "${startDate.month.toString().padLeft(2, '0')}${startDate.day.toString().padLeft(2, '0')}";

    MaximumMinimumTideData res = MaximumMinimumTideData();

    if(Data.location_State != 'Enabled') {
      res.TideState = ['위치 권한이 허용되지 않았습니다'];
      return res;
    }

    res.TideState.clear();
    res.TideVal.clear();
    res.TideTime.clear();
    await Future.delayed(Duration(seconds: 3));
    res.TideState = ['최대 조위', '최소 조위', '최대 조위', '최소 조위'];
    res.TideVal = ['7.08(m)', '1.02(m)', '6.45(m)', '2.12(m)'];
    res.TideTime = ['1:10am', '7:54am', '3:22pm', '10:34pm'];
    return res;

    final request = Uri.parse(getTideForecastURL(ObsCode, Date));
    final response = await http.get(request);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      final data = jsonData['result']['data'] as List<dynamic>;
      final extractedData = data.map((item) {
        return {
          'hl_code': item['hl_code'],
          'tph_time': item['tph_time'],
          'tph_level': item['tph_level'],
        };
      }).toList();

      for(int i = 0; i < extractedData.length; i++) {
        DateTime tph_time = DateTime.parse(extractedData[i]['tph_time']);
        int Hour = tph_time.hour;
        int Min = tph_time.minute;
        String AmPm = 'am';
        if(Hour >= 12) {
          Hour -= 12; AmPm = 'pm';
        }
        String StrTime = Hour.toString()+':'+(Min < 10 ? '0':'')+Min.toString()+AmPm;
        double val = double.parse(extractedData[i]['tph_level'])/100;

        res.TideVal.add(val.toString()+'(m)');
        res.TideTime.add(StrTime);

        if(extractedData[i]['hl_code'] == '고조') {
          res.TideState.add('최대 조위');
        }else{
          res.TideState.add('최소 조위');
        }
      }
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
  List<String> TideState = ['최대 조위'];
  List<String> TideVal = ['xx(m)'];
  List<String> TideTime = ['--:--am'];

}