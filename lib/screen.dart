import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mud_safety/get_api.dart';
import 'package:mud_safety/get_gps.dart';
import 'package:mud_safety/get_height.dart';
import 'package:mud_safety/get_pressure.dart';

import 'package:flutter/services.dart';
import 'package:flutter_barometer/flutter_barometer.dart';
import 'dart:async';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<double> _barometerValues = [0.0];

  List<StreamSubscription<dynamic>> _streamSubscriptions =
  <StreamSubscription<dynamic>>[];

  @override
  Widget build(BuildContext context) {
    final List<String> barometer =
    _barometerValues.map((double v) => v.toStringAsFixed(1)).toList();
    final String pressure = barometer.elementAt(0);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Pressure: $pressure'),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    _streamSubscriptions.add(flutterBarometerEvents.listen((FlutterBarometerEvent event) {
      setState(() {
        _barometerValues = <double>[event.pressure];
      });
    }));
  }
}

/*class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  BarometerValue _currentPressure = BarometerValue(0.0);
  double latitude = 0, longitude = 0;

  @override
  void initState() {
    super.initState();
    FlutterBarometer.currentPressureEvent.listen((event) {
      setState(() {
        _currentPressure = event;
      });
    });

    updateGPS();
  }

  Future<void> updateGPS() async {
    GpsReceive a = GpsReceive();
    var b = await a.getLocation();
    latitude = b.$1; longitude = b.$2;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('flutter_barometer'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Running on: $_platformVersion\n',
                style: TextStyle(fontSize: 30),
              ),
              Text(
                '${(_currentPressure.hectpascal * 1000).round() / 1000} hPa',
                style: TextStyle(
                  fontSize: 70,
                ),
              ),
              Text(
                '${(_currentPressure.inchOfMercury * 1000).round() / 1000} inHg',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              Text(
                '${(_currentPressure.millimeterOfMercury * 1000).round() / 1000} mmHg',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              Text(
                '${(_currentPressure.poundsSquareInch * 1000).round() / 1000} psi',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              Text(
                '${(_currentPressure.atm * 1000).round() / 1000} atm',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              Text(
                '$latitude',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Future<String> checkPermission() async{
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if(!isLocationEnabled) {
      return '위치 서비스를 활성화해주세요';
    }

    LocationPermission checkedPermission = await Geolocator.checkPermission();

    if(checkedPermission == LocationPermission.denied) {
      checkedPermission = await Geolocator.requestPermission();

      if(checkedPermission == LocationPermission.denied) {
        return '위치 권한을 허가해주세요';
      }
    }

    if(checkedPermission == LocationPermission.deniedForever) {
      return '앱의 위치 권한을 설정에서 허가해주세요';
    }

    return '위치 권한이 허가 되었습니다';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: FutureBuilder<String>(
        future: checkPermission(),
        builder: (context, snapshot) {
          if(!snapshot.hasData && snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if(snapshot.data == '위치 권한이 허가 되었습니다') {
            return Center(
              child: ButtonWidget(),
            );
          }else{
            return Center(
              child: Text(
                snapshot.data.toString(),
              ),
            );
          }
        }
      ),
    );
  }
}

AppBar renderAppBar() {
  return AppBar(
    centerTitle: true,
    title: Text(
      'gps test',
      style: TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.w700,
      ),
    ),
    backgroundColor: Colors.white,
  );
}

class ButtonWidget extends StatefulWidget {
  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  String latitude = 'Button';
  String longitude = 'button';

  Future<void> getLocation() async {
    GpsReceive gpsReceive = GpsReceive();

    //Map<String, double> gpslocation = await gpsReceive.getLocation();
    //print(gpslocation['latitude']);
    //print(gpslocation['longitude']);
  }

  Future<void> getHeight() async {
    HeightReveive heightReveive = HeightReveive();
    FlutterBarometer pressure = FlutterBarometer();

    FlutterBarometer.currentPressure.then((value) {
      print('Current Pressure: ${value.hectpascal} hPa');
      print('Inch of Mercury: ${value.inchOfMercury} inHg');
      print('Millimeter of Mercury: ${value.millimeterOfMercury} mmHg');
      print('Pounds per Square Inch: ${value.poundsSquareInch} psi');
      print('Atmospheres: ${value.atm} atm');
    }).catchError((error) {
      print('Error fetching current pressure: $error');
    });

    //Map<String, double> weather = await heightReveive.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        TideReceive myclass = TideReceive();

        future: myclass.getTide();
        future: getLocation();
        future: getHeight();
      },
      child: Text(longitude),
    );
  }
}
*/