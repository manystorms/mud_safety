import 'get_data.dart';
import 'package:flutter_barometer/flutter_barometer.dart';

void PressureReceive() {
  flutterBarometerEvents.listen((FlutterBarometerEvent event) {
    if(Data.Pressure != event.pressure) {
      Data.Pressure = event.pressure;
      Data.Height = event.pressure;
      RebootScreen++;
    }
  });
}