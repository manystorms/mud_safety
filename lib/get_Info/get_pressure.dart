import 'get_data.dart';
import 'dart:math';
import 'package:flutter_barometer/flutter_barometer.dart';

void PressureReceive() {
  const Rs = 287.058; //비기체상수
  const g = 9.8; //중력가속도

  flutterBarometerEvents.listen((FlutterBarometerEvent event) {
    if(Data.Pressure != event.pressure) {
      Data.Pressure = event.pressure;

      double Density = (Data.Weather_Pressure*0.750063)/Rs*Data.Weather_Temperature;

      double Height = (Data.Pressure*100-Data.Weather_Pressure*100)/(Density*g);
      Data.Height = Height;
      Data.Tide_Gap = Data.Pressure;
    }
  });
}