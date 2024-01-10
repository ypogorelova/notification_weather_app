import 'package:weather_app/utils/icons.dart';

class WeatherDataCurrent {
  final Current current;

  WeatherDataCurrent({required this.current});

  factory WeatherDataCurrent.fromJson(Map<String, dynamic> json) =>
      WeatherDataCurrent(current: Current.fromJson(json));
}

class Current {
  int? temp;
  int? feelsLike;
  int? feelsLikeShade;
  double? windSpeed;
  int? wetBulbTemp;
  int? dewPoint;
  int? humidity;
  String? uvIndex;
  String? uvIndexText;
  int? clouds;
  double? pressure;
  Weather? weather;

  Current({
    this.temp,
    this.humidity,
    this.clouds,
    this.uvIndex,
    this.uvIndexText,
    this.weather,
    this.feelsLike,
    this.feelsLikeShade,
    this.windSpeed,
    this.wetBulbTemp,
    this.pressure,
    this.dewPoint,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        temp: (json['Temperature']['Imperial']['Value'] as num?)?.round(),
        feelsLike:
            (json['RealFeelTemperature']['Imperial']['Value'] as num?)?.round(),
        feelsLikeShade:
            (json['RealFeelTemperatureShade']['Imperial']['Value'] as num?)
                ?.round(),
        windSpeed: (json['Wind']['Speed']['Imperial']['Value'] as double?),
        wetBulbTemp:
            (json['WetBulbTemperature']['Imperial']['Value'] as num?)?.round(),
        dewPoint: (json['DewPoint']['Imperial']['Value'] as num?)?.round(),
        humidity: json['RelativeHumidity'] as int?,
        uvIndex: json['UVIndex'].toString(),
        uvIndexText: (json['UVIndexText'] as String?),
        clouds: json['CloudCover'] as int?,
        pressure: (json['Pressure']['Imperial']['Value'] as double?),
        weather: Weather.fromJson(json),
      );

  Map<String, dynamic> toJson() => {
        'uvIndex': uvIndex,
        'uvIndexText': uvIndexText,
        'temp': temp,
        'feelsLike': feelsLike,
        'feelsLikeShade': feelsLikeShade,
        'windSpeed': windSpeed,
        'wetBulbTemp': wetBulbTemp,
        'dewPoint': dewPoint,
        'humidity': humidity,
        'clouds': clouds,
        'pressure': pressure,
        'weather': weather?.toJson(),
      };
}

class Weather {
  String? description;
  String? icon;

  Weather({this.description, this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        description: json['WeatherText'] as String?,
        icon: icons[json['WeatherIcon'] as int?],
      );

  Map<String, dynamic> toJson() => {
        'description': description,
        'icon': icon,
      };
}
