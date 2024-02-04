import 'dart:convert';

import 'package:fluttertest/Screens/climateScreen/model/weather_data_daily.dart';
import 'package:fluttertest/Screens/climateScreen/model/weather_data_hourly.dart';
import 'package:fluttertest/Screens/climateScreen/utils/api_url.dart';
import 'package:fluttertest/Screens/climateScreen/model/weather_data.dart';
import 'package:fluttertest/Screens/climateScreen/model/weather_data_current.dart';
import 'package:http/http.dart' as http;

class fetchWeatherAPI {
  WeatherData? weatherData;

  //processing data from response -> to json
  Future<WeatherData> processData(lat, lon) async {
    var response = await http.get(Uri.parse(apiURL(lat, lon)));
    var jsonString = jsonDecode(response.body);
    weatherData = WeatherData(
      WeatherDataCurrent.fromJson(jsonString), 
      WeatherDataHourly.fromJson(jsonString), 
      WeatherDataDaily.fromJson(jsonString),
      );

    return weatherData!;
  }
}

