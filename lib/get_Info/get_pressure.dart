import 'get_data.dart';
import 'dart:math';
import 'package:flutter_barometer/flutter_barometer.dart';

void PressureReceive() {

  flutterBarometerEvents.listen((FlutterBarometerEvent event) {
    if(Data.Pressure != event.pressure && Data.Weather_Error == 0) {
      Data.Pressure = event.pressure;
      double Rs = 287.058; //비기체상수
      double g = 9.8; //중력가속도

      double Height = (Rs*Data.Weather_Temperature/g)*log(Data.Weather_Pressure/Data.Pressure);
      Data.Height = Height;

      Data.Tide_Gap = Data.Height-Data.obs_Graph_y[0]/100;



      Data.Tide_Gap = Data.Pressure;
    }
  });
}