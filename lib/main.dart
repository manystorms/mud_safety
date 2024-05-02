import 'package:mud_safety/screen.dart';
import 'package:flutter/material.dart';
import 'package:sensor_library/models/raw_sensors/barometer.dart';

void main() {
  runApp(HomeScreen());
}

class BarometerRoute extends StatefulWidget {
  const BarometerRoute({Key? key}) : super(key: key);

  @override
  _BarometerRouteState createState() => _BarometerRouteState();
}

class _BarometerRouteState extends State<BarometerRoute> {
  double hpa = 0.0;
  double mmm = 0.0;
  late Barometer barometer;

  @override
  void initState() {
    super.initState();
    barometer = Barometer(inMillis: 500);
    barometer.getRaw().listen((element) {
      double valueInHectopascal = element.hectpascal;
      double valueInMMMercury = element.millimeterOfMercury;

      setState(() {
        hpa = valueInHectopascal;
        mmm = valueInMMMercury;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Barometer"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Center(
                    child: Text("hectpascal".toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold))),
                Center(
                    child: Text(
                      hpa.toStringAsFixed(2),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 30),
                    )),
                const SizedBox(height: 30),
                Center(
                    child: Text("Millimeter Of Mercury".toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold))),
                Center(
                    child: Text(
                      mmm.toStringAsFixed(2),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 30),
                    )),
                const SizedBox(height: 30),
                const Center(
                    child: Text(
                      "All Values fixed to 2 Decimals",
                      style: TextStyle(fontSize: 14),
                    )),
              ],
            )));
  }
}