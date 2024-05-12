import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mud_safety/get_api.dart';
import 'package:mud_safety/get_gps.dart';
import 'package:mud_safety/get_height.dart';
import 'package:mud_safety/get_pressure.dart';

class MyApp extends StatelessWidget {
  Future<void> getPressure() async {
    WidgetsFlutterBinding.ensureInitialized();

    // 현재 압력 값을 가져오기 위해 currentPressure 메서드 호출
    try {
      BarometerValue pressureValue = await FlutterBarometer.currentPressure;
      // pressureValue에서 필요한 정보를 추출하여 사용
      print('Current Pressure in hectopascal: ${pressureValue.hectpascal}');
      print('Current Pressure in inch of Mercury: ${pressureValue.inchOfMercury}');
      print('Current Pressure in millimeter of Mercury: ${pressureValue.millimeterOfMercury}');
      print('Current Pressure in pounds per square inch: ${pressureValue.poundsSquareInch}');
      print('Current Pressure in atmospheres: ${pressureValue.atm}');
    } catch (error) {
      // 오류 처리
      print('Error fetching current pressure: $error');
    }
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Button Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              future: getPressure();
            },
            child: Text('Press Me'),
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

    Map<String, double> gpslocation = await gpsReceive.getLocation();
    print(gpslocation['latitude']);
    print(gpslocation['longitude']);
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

    Map<String, double> weather = await heightReveive.getWeather();
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