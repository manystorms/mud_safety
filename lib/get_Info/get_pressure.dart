import 'get_data.dart';
import 'package:flutter_barometer/flutter_barometer.dart';

void PressureReceive() {
  const Rs = 287.058; //비기체상수
  const g = 9.8; //중력가속도

  flutterBarometerEvents.listen((FlutterBarometerEvent event) {
    if(Data.Pressure != event.pressure) {
      Data.Pressure = event.pressure;

      double Density = Data.Pressure/Rs*Data.Weather_Temperature;
      Data.Height = Data.Pressure;
    }
  });
}