import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mud_safety/get_api.dart';
import 'package:mud_safety/get_gps.dart';
import 'package:mud_safety/get_height.dart';

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
    future: heightReveive.getPressure();
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