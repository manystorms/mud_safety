import 'package:geolocator/geolocator.dart';

class GpsReceive {
  Future<String> checkPermission() async{
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if(!isLocationEnabled) {
      return 'UnEnabled';
    }

    LocationPermission checkedPermission = await Geolocator.checkPermission();

    if(checkedPermission == LocationPermission.denied) {
      checkedPermission = await Geolocator.requestPermission();

      if(checkedPermission == LocationPermission.denied) {
        return 'Denied';
      }
    }

    if(checkedPermission == LocationPermission.deniedForever) {
      return 'DeniedForever';
    }

    return 'Enabled';
  }

  Future<(double, double, String)> getLocation() async {
    String Permission_State = await checkPermission();
    print(Permission_State);
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // 위도와 경도 업데이트
    return (position.latitude, position.longitude, Permission_State);
  }
}