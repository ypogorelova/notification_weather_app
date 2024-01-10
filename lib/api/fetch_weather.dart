import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';
import 'package:weather_app/api/api_url.dart';
import 'package:weather_app/model/location_data.dart';
import 'package:weather_app/model/weather_data.dart';
import 'package:weather_app/model/weather_data_current.dart';
import 'package:weather_app/model/weather_data_daily.dart';
import 'package:weather_app/model/weather_data_hourly.dart';

class FetchLocationKeyByGeoAPI {
  LocationKey? locationKey;

  // processing the data from response -> to json
  Future<LocationKey?> processData(latitude, longitude) async {
    var response = await retry(
        () => http
            .get(Uri.parse(locationKeybyGeoURL(latitude, longitude)))
            .timeout(const Duration(seconds: 5)),
        retryIf: (e) => e is SocketException || e is TimeoutException);
    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      locationKey = LocationKey.fromJson(jsonString[0]);
      return locationKey;
    } else {
      return null;
    }
  }
}

class FetchLocationKeyByCityAPI {
  LocationKey? locationKey;

  // processing the data from response -> to json
  Future<LocationKey?> processData(city) async {
    var response = await retry(
      () => http
          .get(Uri.parse(locationKeybyCityURL(city)))
          .timeout(const Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    if (response.statusCode == 200) {
      var jsonString = jsonDecode(response.body);
      locationKey = LocationKey.fromJson(jsonString);
      return locationKey;
    } else {
      return null;
    }
  }
}

class FetchWeatherAPI {
  WeatherData? weatherData;
  var currentJsonString;
  var dailyJsonString;
  var hourlyJsonString;

  // processing the data from response -> to json
  Future<WeatherData> processData(key) async {
    var currentResponse = await retry(
      () => http
          .get(Uri.parse(currentWeatherURL(key)))
          .timeout(const Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (currentResponse.statusCode == 200) {
      currentJsonString = jsonDecode(currentResponse.body)[0];
    }
    ;

    var dailyResponse = await retry(
      () => http
          .get(Uri.parse(dailyWeatherURL(key)))
          .timeout(const Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (dailyResponse.statusCode == 200) {
      dailyJsonString = jsonDecode(dailyResponse.body);
    }
    ;

    var hourlyResponse = await retry(
      () => http
          .get(Uri.parse(hourlyWeatherURL(key)))
          .timeout(const Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );

    if (hourlyResponse.statusCode == 200) {
      hourlyJsonString = jsonDecode(hourlyResponse.body);
    }
    ;

    weatherData = WeatherData(
        WeatherDataCurrent.fromJson(currentJsonString),
        WeatherDataHourly.fromJson(hourlyJsonString),
        WeatherDataDaily.fromJson(dailyJsonString));

    return weatherData!;
  }
}
