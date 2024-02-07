import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/api_key.dart';
import 'package:weather_app/cities_name.dart';
import 'package:weather_app/colors.dart';
import 'package:weather_app/add_info_item.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:weather_app/weather_forecast.dart';
import 'package:http/http.dart' as http;
import 'package:weather_icons/weather_icons.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({super.key});

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  String selectedValue = 'Karachi';
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  Future getCurrentWeather() async {
    try {
      String cityName = selectedValue.toString();
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
          centerTitle: false,
          title: const Text('Weather App'),
          actions: [
            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: Text(
                  'Select Item',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                items: cities
                    .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                value: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value!;
                  });
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 40,
                  width: 130,
                ),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 130,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
                dropdownSearchData: DropdownSearchData(
                  searchController: textEditingController,
                  searchInnerWidgetHeight: 50,
                  searchInnerWidget: Container(
                    height: 50,
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 4,
                      right: 8,
                      left: 8,
                    ),
                    child: TextFormField(
                      expands: true,
                      maxLines: null,
                      controller: textEditingController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        hintText: 'Search for an item...',
                        hintStyle: const TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    return item.value.toString().contains(searchValue);
                  },
                ),
                //This to clear the search value when you close the menu
                onMenuStateChange: (isOpen) {
                  if (!isOpen) {
                    textEditingController.clear();
                  }
                },
              ),
            ),
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

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: DefaultTextStyle(
                  style: TextStyle(color: whiteColor),
                  child: IconTheme(
                    data: IconThemeData(color: whiteColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Center(
                            child: Text(
                          selectedValue,
                          style: const TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold),
                        )),
                        const SizedBox(
                          height: 20,
                        ),
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
                          height: 130,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 8,
                            itemBuilder: (context, index) {
                              final hourlyForecast = data['list'][index + 1];
                              final hourlyTemp = double.parse(
                                      hourlyForecast['main']['temp']
                                          .toString()) -
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
              ),
            );
          },
        ));
  }
}
