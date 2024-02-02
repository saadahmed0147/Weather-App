import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/colors.dart';
import 'package:weather_app/add_info_item.dart';
import 'package:weather_app/weather_forecast.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: bgColor,
        centerTitle: true,
        title: const Text('Weather App'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: DefaultTextStyle(
        style: TextStyle(color: whiteColor),
        child: IconTheme(
          data: IconThemeData(color: whiteColor),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    color: cardColor,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 10,
                          sigmaY: 10,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text(
                                '300.67°F',
                                style: TextStyle(
                                    fontSize: 30,
                                    color: whiteColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Icon(
                                Icons.cloud,
                                color: whiteColor,
                                size: 70,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                'Rain',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: whiteColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Weather Forcast',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: whiteColor),
                ),
                const SizedBox(
                  height: 16,
                ),
                const SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      WeatherForecast(
                        time: '12:00',
                        icon: Icons.cloud,
                        temp: '301.54',
                      ),
                      WeatherForecast(
                        time: '12:00',
                        icon: Icons.cloud,
                        temp: '301.54',
                      ),
                      WeatherForecast(
                        time: '12:00',
                        icon: Icons.cloud,
                        temp: '301.54',
                      ),
                      WeatherForecast(
                        time: '12:00',
                        icon: Icons.cloud,
                        temp: '301.54',
                      ),
                      WeatherForecast(
                        time: '12:00',
                        icon: Icons.cloud,
                        temp: '301.54',
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Additional Information',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: whiteColor),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AddInfoItem(
                      icon: Icons.water_drop,
                      label: 'Humidity',
                      data: '95',
                    ),
                    AddInfoItem(
                      icon: Icons.air,
                      label: 'Wind Speed',
                      data: '7.67',
                    ),
                    AddInfoItem(
                      icon: Icons.beach_access,
                      label: 'Pressure',
                      data: '1006',
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
