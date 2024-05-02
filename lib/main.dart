import 'package:mud_safety/screen.dart';
import 'package:flutter/material.dart';
import 'package:sensor_library/models/raw_sensors/barometer.dart';

void main() {
  //runApp(HomeScreen());
  runApp(MaterialApp(
    home: PressureDisplay(),
  ));
}

class PressureDisplay extends StatefulWidget {
  const PressureDisplay({Key? key}) : super(key: key);

  @override
  _PressureDisplayState createState() => _PressureDisplayState();
}

class _PressureDisplayState extends State<PressureDisplay> {
  double pressureValue = 0.0; // 기압 값을 저장할 변수
  late Barometer barometer; // Barometer 객체

  @override
  void initState() {
    super.initState();
    // Barometer 객체 초기화 및 데이터 수신 이벤트 구독
    barometer = Barometer(inMillis: 1000);
    barometer.getRaw().listen((element) {
      setState(() {
        pressureValue = element.hectpascal; // 기압 값 업데이트
        print(pressureValue);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pressure Display'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pressure: ${pressureValue.toStringAsFixed(2)} hPa', // 기압 값 출력
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}