import 'get_gps.dart';
import 'get_tide.dart';
import 'get_weather.dart';
import 'get_pressure.dart';
import 'Timer.dart';
import 'dart:async';
import 'package:intl/intl.dart';

ReceiveData Data = ReceiveData();

Future<void> InitialData() async {
  GpsReceive GpsReceiveClass = GpsReceive();
  WeatherReveive WeatherReceiveClass = WeatherReveive();

  GpsReceiveClass.updateLocation();
  while (Data.location_State != 'Enabled') {
    await Future.delayed(Duration(seconds: 1));
  }
  updateTide();
  WeatherReceiveClass.updateWeather();
}

void UpdateData() {
  PressureReceive();

  InitialData();

  GpsReceive GpsReceiveClass = GpsReceive();
  WeatherReveive WeatherReceiveClass = WeatherReveive();
  TideReceive TideReceiveClass = TideReceive();
  ObsData ObsDataClass = ObsData();
  ObsGraphData ObsGraphDataClass = ObsGraphData();

  Timer.periodic(Duration(seconds: 600), (Timer timer) {
    GpsReceiveClass.updateLocation();
  });

  Timer.periodic(Duration(seconds: 1800), (Timer timer) {
    updateTide();
  });

  Timer.periodic(Duration(seconds: 60), (Timer timer) {
    ObsDataClass.obs_x = Data.obs_x;
    ObsDataClass.obs_y = Data.obs_y;
    ObsDataClass.obsState = Data.obs_Graph_name;
    ObsGraphDataClass = TideReceiveClass.updateTideGraphData(ObsDataClass);

    Data.obs_Graph_name = ObsGraphDataClass.obsGraphName;
    Data.obs_Graph_x = ObsGraphDataClass.obs_Graph_x;
    Data.obs_Graph_y = ObsGraphDataClass.obs_Graph_y;
  });
  Timer.periodic(Duration(seconds: 60), (Timer timer) {
    WeatherReceiveClass.updateWeather();
  });
  Timer.periodic(Duration(seconds: 60), (Timer timer) {
    updateSettingTime();
  });
}

Future <void> updateTide() async {
  TideReceive TideReceiveClass = TideReceive();
  ObsData ObsDataClass = ObsData();
  ObsGraphData ObsGraphDataClass = ObsGraphData();

  ObsDataClass = await TideReceiveClass.updateTide();
  ObsGraphDataClass = TideReceiveClass.updateTideGraphData(ObsDataClass);

  Data.obs_x = ObsDataClass.obs_x;
  Data.obs_y = ObsDataClass.obs_y;

  Data.obs_Graph_x = ObsGraphDataClass.obs_Graph_x;
  Data.obs_Graph_y = ObsGraphDataClass.obs_Graph_y;
  Data.obs_Graph_name = ObsGraphDataClass.obsGraphName;

  updateSettingTime();
}

class ReceiveData {
  double latitude = 0;
  double longitude = 0;
  String location_State = 'a';

  String obs_Graph_name = '데이터를 받아오고 있습니다';
  List<int> obs_Graph_x = [0];
  List<double> obs_Graph_y = [0];
  List<int> obs_x = [0];
  List<double> obs_y = [0];

  double Weather_Pressure = 0;
  double Weather_Temperature = 0;
  double Weather_Humidity = 65;
  int Weather_Error = 1;

  double Pressure = 0;
  double Height = 0;
  double Correction = 0;
  double Tide_Gap = 5;
  int AlertTime = 1716129253; //UnixTime 기준
}

int getUnixTime() {
  DateTime now = DateTime.now();
  return now.millisecondsSinceEpoch ~/ 1000;
}

String getToday() {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('yyyyMMdd');
  String strToday = formatter.format(now);
  return strToday;
}