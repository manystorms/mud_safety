import 'get_gps.dart';
import 'get_tide.dart';
import 'get_weather.dart';

ReceiveData Data = ReceiveData();

Future<ReceiveData> UpdateData() async {
  ReceiveData res = ReceiveData();

  GpsReceive getLocationClass = GpsReceive();
  TideReceive getTideClass = TideReceive();
  WeatherReveive getWeatherClass = WeatherReveive();

  var LocationData = await getLocationClass.getLocation();
  res.obsData = await getTideClass.getTide();
  var WeatherData = await getWeatherClass.getWeather();

  res.latitude = LocationData.$1;
  res.longtitude = LocationData.$2;
  res.location_Permission_State = LocationData.$3;

  res.Weather_Pressure = WeatherData.$1;
  res.Weather_Temperature = WeatherData.$2;
  res.Weather_Error = WeatherData.$3;

  return res;
}

class ReceiveData {
  double latitude = 0;
  double longtitude = 0;
  String location_Permission_State = 'a';

  Map<String, double> obsData = {};

  double Weather_Pressure = 0;
  double Weather_Temperature = 0;
  int Weather_Error = 0;

  double Pressure = 0;
  double Height = 0;

  double Tide_Gap = 0;
}