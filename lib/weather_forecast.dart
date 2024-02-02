import 'package:flutter/material.dart';
import 'package:weather_app/colors.dart';

class WeatherForecast extends StatefulWidget {
  final String time;
  final IconData icon;
  final String temp;
  const WeatherForecast(
      {super.key, required this.time, required this.icon, required this.temp});

  @override
  State<WeatherForecast> createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: cardColor,
      child: Container(
        width: 90,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        child: Column(
          children: [
            Text(
              widget.time,
              style: TextStyle(color: whiteColor, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Icon(
              widget.icon,
              size: 30,
            ),
            const SizedBox(height: 8),
            Text(
              widget.temp,
              style: TextStyle(color: greyColor),
            ),
          ],
        ),
      ),
    );
  }
}
