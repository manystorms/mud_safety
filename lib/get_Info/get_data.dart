import 'get_gps.dart';
import 'get_tide.dart';
import 'get_weather.dart';

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

  res.Pressure = WeatherData.$1;
  res.Temperature = WeatherData.$2;
  res.Weather_Error = WeatherData.$3;

  return res;
}

class ReceiveData {
  double latitude = 0;
  double longtitude = 0;
  String location_Permission_State = '';

  Map<String, double> obsData = {};

  double Pressure = 0;
  double Temperature = 0;
  int Weather_Error = 0;
}