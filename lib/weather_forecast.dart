import 'dart:ui';

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
      elevation: 10,
      color: cardColor,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10,
            sigmaY: 10,
          ),
          child: Container(
            width: 100,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            child: Column(
              children: [
                Text(
                  widget.time,
                  style:
                      TextStyle(color: whiteColor, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Icon(
                  widget.icon,
                  size: 30,
                ),
                const SizedBox(height: 20),
                Text(
                  widget.temp,
                  style: TextStyle(color: greyColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
