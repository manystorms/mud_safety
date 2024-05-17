import 'package:geolocator/geolocator.dart';
import 'package:mud_safety/get_Info/get_data.dart';

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

  Future<void> updateLocation() async {
    String Permission_State = await checkPermission();
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // 위도와 경도 업데이트
    Data.latitude = position.latitude;
    Data.longitude = position.longitude;
    Data.location_State = Permission_State;
  }
}