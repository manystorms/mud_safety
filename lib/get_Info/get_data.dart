import 'get_gps.dart';
import 'get_tide.dart';
import 'get_weather.dart';
import 'get_pressure.dart';
import 'dart:async';
import 'package:intl/intl.dart';

ReceiveData Data = ReceiveData();

Future<void> InitialData() async {
  GpsReceive GpsReceiveClass = GpsReceive();
  TideReceive TideReceiveClass = TideReceive();
  WeatherReveive WeatherReceiveClass = WeatherReveive();

  GpsReceiveClass.updateLocation();
  while (Data.location_State != 'Enabled') {
    await Future.delayed(Duration(seconds: 1));
  }
  TideReceiveClass.updateTide();
  WeatherReceiveClass.updateWeather();
}

void UpdateData() {
  PressureReceive();

  InitialData();

  GpsReceive GpsReceiveClass = GpsReceive();
  TideReceive TideReceiveClass = TideReceive();
  WeatherReveive WeatherReceiveClass = WeatherReveive();

  Timer.periodic(Duration(seconds: 600), (Timer timer) {
    GpsReceiveClass.updateLocation();
  });

  Timer.periodic(Duration(seconds: 1800), (Timer timer) {
    TideReceiveClass.updateTide();
  });

  Timer.periodic(Duration(seconds: 60), (Timer timer) {
    WeatherReceiveClass.updateWeather();
  });
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
  int Weather_Error = 0;

  double Pressure = 0;
  double Height = 0;

  double Tide_Gap = 5;
  int AlertTime = 0; //UnixTime 기준

  int TodayDate = 20240517; //yyyy-MM-dd
  int NextDayDate = 20240518; //yyyy-MM-dd
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