import 'package:flutter/material.dart';
import 'package:weather_app/weather_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true), // sadded theme here
      debugShowCheckedModeBanner: false,
      home: const WeatherApp(),
    );
  }
}
