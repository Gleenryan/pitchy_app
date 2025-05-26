import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'sensor_data_page.dart'; // <--- import your new page

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ESP32 Monitor',
      theme: ThemeData(primarySwatch: Colors.green),
      home: SensorDataPage(), // <--- show live updating data
    );
  }
}
