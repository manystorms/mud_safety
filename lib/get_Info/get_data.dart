import 'get_gps.dart';
import 'get_tide.dart';
import 'get_weather.dart';

ReceiveData Data = ReceiveData();
int RebootScreen = 0;

Future<void> UpdateData() async {
  GpsReceive GpsReceiveClass = GpsReceive();
  TideReceive TideReceiveClass = TideReceive();
  print('start');
  var LocationData = await GpsReceiveClass.getLocation();
  Data.latitude = LocationData.$1;
  Data.longitude = LocationData.$2;
  Data.location_Permission_State = LocationData.$3;

  TideReceiveClass.updateTide();
}

class ReceiveData {
  double latitude = 0;
  double longitude = 0;
  String location_Permission_State = 'a';

  String obs_Graph_name = '데이터를 받아오고 있습니다';
  List<int> obs_x = [0];
  List<double> obs_y = [0];

  double Weather_Pressure = 0;
  double Weather_Temperature = 0;
  int Weather_Error = 0;

  double Pressure = 0;
  double Height = 0;

  double Tide_Gap = 10;
}