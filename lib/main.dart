import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ESP32 Monitor',
      theme: ThemeData(primarySwatch: Colors.green),
      home: SensorDataPage(),
    );
  }
}

class SensorDataPage extends StatefulWidget {
  const SensorDataPage({super.key});

  @override
  _SensorDataPageState createState() => _SensorDataPageState();
}

class _SensorDataPageState extends State<SensorDataPage> {
  double temperature = 0;
  int soil = 0;
  int water = 0;

  late DatabaseReference sensorRef;

  @override
  void initState() {
    super.initState();
    sensorRef = FirebaseDatabase.instance.ref().child('sensor');
    sensorRef.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        setState(() {
          temperature = (data['temperature'] ?? 0).toDouble();
          soil = data['soil'] ?? 0;
          water = data['water'] ?? 0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ESP32 Monitoring')),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Temperature: ${temperature.toStringAsFixed(1)} °C',
                  style: TextStyle(fontSize: 22),
                ),
                SizedBox(height: 20),
                Text('Soil Moisture: $soil %', style: TextStyle(fontSize: 22)),
                SizedBox(height: 20),
                Text('Water Level: $water %', style: TextStyle(fontSize: 22)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
