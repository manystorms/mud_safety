import 'get_data.dart';
import 'package:flutter_barometer/flutter_barometer.dart';

void PressureReceive() {
  print('b');
  flutterBarometerEvents.listen((FlutterBarometerEvent event) {
    print('a');
    print(event);
  });
}