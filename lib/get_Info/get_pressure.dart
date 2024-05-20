import 'get_data.dart';
import 'dart:math';
import 'package:flutter_barometer/flutter_barometer.dart';

void PressureReceive(){

  flutterBarometerEvents.listen((FlutterBarometerEvent event) {
    if(Data.Pressure != event.pressure && Data.Weather_Error == 0) {
      Data.Pressure = event.pressure;
      double Rd = 287.058; //건조 기체 상수
      double g = 9.8; //중력가속도

      double es = 0.6108*exp(17.67*(Data.Weather_Temperature-273.15)/((Data.Weather_Temperature-273.15)+243.5))*1000;
      double e = Data.Weather_Humidity*es;
      double SteamMole = (Data.Pressure)/101325;
      double DryMole = 1-SteamMole;
      double AirMolecule = DryMole*28.866+SteamMole*18;
      double Rv = Rd*28.966/AirMolecule;

      double Height = (Rv*Data.Weather_Temperature/g)*log(Data.Weather_Pressure/Data.Pressure);

      String StrHeight = Height.toStringAsFixed(4);
      Data.Height = double.parse(StrHeight);

      if(Data.obs_Graph_x.isNotEmpty) Data.Tide_Gap = Data.Height-Data.obs_Graph_y[0]/100;
    }
  });
}