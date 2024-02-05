import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/api_key.dart';
import 'package:weather_app/colors.dart';
import 'package:weather_app/add_info_item.dart';
import 'package:weather_app/weather_forecast.dart';
import 'package:http/http.dart' as http;
import 'package:weather_icons/weather_icons.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  Future getCurrentWeather() async {
    try {
      String cityName = 'Karachi';
      final res = await http.get(
        Uri.parse(
            'http://api.openweathermap.org/data/2.5/forecast?q=$cityName,&APPID=$openWeatherApiKey'),
      );

      final data = jsonDecode(res.body);
      if (data['cod'] != '200') {
        throw 'An Unexpexted Error Occurred';
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

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
            IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: const Icon(Icons.refresh)),
          ],
        ),
        body: FutureBuilder(
          future: getCurrentWeather(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: whiteColor),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                  style: TextStyle(color: whiteColor),
                ),
              );
            }

            final data = snapshot.data!;

            final currentWeatherData = data['list'][0];

            final currentTemp = currentWeatherData['main']['temp'];
            String currentTempCelsius =
                (currentTemp - 273.15).toStringAsFixed(2);

            final currentSky = currentWeatherData['weather'][0]['main'];
            final currentHumidity = currentWeatherData['main']['humidity'];
            final currentWindSpeed = currentWeatherData['wind']['speed'];
            final currentPressure = currentWeatherData['main']['pressure'];

            return Padding(
              padding: const EdgeInsets.all(16),
              child: DefaultTextStyle(
                style: TextStyle(color: whiteColor),
                child: IconTheme(
                  data: IconThemeData(color: whiteColor),
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
                                      '$currentTempCelsius°C',
                                      style: TextStyle(
                                          fontSize: 30,
                                          color: whiteColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Icon(
                                      currentSky == 'Clouds'
                                          ? WeatherIcons.cloudy
                                          : currentSky == 'Rain'
                                              ? WeatherIcons.rain
                                              : WeatherIcons.day_sunny,
                                      color: whiteColor,
                                      size: 70,
                                    ),
                                    const SizedBox(height: 30),
                                    Text(
                                      currentSky,
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
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 8,
                          itemBuilder: (context, index) {
                            final hourlyForecast = data['list'][index + 1];
                            final hourlyTemp = double.parse(
                                    hourlyForecast['main']['temp'].toString()) -
                                273.15;

                            final hourlyTime =
                                DateTime.parse(hourlyForecast['dt_txt']);
                            final hourlySky =
                                data['list'][index + 1]['weather'][0]['main'];
                            return WeatherForecast(
                              time: DateFormat.jm().format(hourlyTime),
                              icon: hourlySky.toString() == 'Clouds'
                                  ? WeatherIcons.cloudy
                                  : hourlySky.toString() == 'Rain'
                                      ? WeatherIcons.rain
                                      : WeatherIcons.day_sunny,
                              temp: '${hourlyTemp.toStringAsFixed(2)}°C',
                            );
                          },
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AddInfoItem(
                            icon: Icons.water_drop,
                            label: 'Humidity',
                            data: currentHumidity.toString(),
                          ),
                          AddInfoItem(
                            icon: Icons.air,
                            label: 'Wind Speed',
                            data: currentWindSpeed.toString(),
                          ),
                          AddInfoItem(
                            icon: Icons.beach_access,
                            label: 'Pressure',
                            data: currentPressure.toString(),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
