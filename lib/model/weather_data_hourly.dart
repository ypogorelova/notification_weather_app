import 'package:weather_app/utils/icons.dart';

class WeatherDataHourly {
  List<Hourly> hourly;

  WeatherDataHourly({required this.hourly});

  factory WeatherDataHourly.fromJson(List<dynamic> json) => WeatherDataHourly(
      hourly: List<Hourly>.from(json.map((e) => Hourly.fromJson(e))));
}

class Hourly {
  int? dt;
  int? temp;
  int? feelsLike;
  int? feelsLikeShade;
  int? wetBulb;
  int? dewPoint;
  double? windSpeed;
  double? rainProb;
  double? snowProb;
  double? iceProb;
  Weather? weather;

  Hourly({
    this.dt,
    this.temp,
    this.feelsLike,
    this.feelsLikeShade,
    this.wetBulb,
    this.dewPoint,
    this.windSpeed,
    this.rainProb,
    this.snowProb,
    this.iceProb,
    this.weather,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
        dt: json['EpochDateTime'] as int?,
        temp: (json['Temperature']['Value'] as num?)?.round(),
        feelsLike: (json['RealFeelTemperature']['Value'] as num?)?.round(),
        feelsLikeShade:
            (json['RealFeelTemperatureShade']['Value'] as num?)?.round(),
        wetBulb: (json['WetBulbTemperature']['Value'] as num?)?.round(),
        dewPoint: (json['DewPoint']['Value'] as num?)?.round(),
        windSpeed: (json['Wind']['Speed']['Value'] as double?),
        rainProb: (json['RainProbability'] as num?)?.toDouble(),
        snowProb: (json['SnowProbability'] as num?)?.toDouble(),
        iceProb: (json['IceProbability'] as num?)?.toDouble(),
        weather: Weather.fromJson(json),
      );

  Map<String, dynamic> toJson() => {
        'dt': dt,
        'temp': temp,
        'feelsLike': feelsLike,
        'feelsLikeShade': feelsLikeShade,
        'wetBulb': wetBulb,
        'dewPoint': dewPoint,
        'rainProb': rainProb,
        'snowProb': snowProb,
        'iceProb': iceProb,
        'weather': weather?.toJson(),
      };
}

class Weather {
  String? description;
  String? icon;

  Weather({this.description, this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        description: json['IconPhrase'] as String?,
        icon: (icons[json['WeatherIcon'] as int?]),
      );

  Map<String, dynamic> toJson() => {
        'description': description,
        'icon': icon,
      };
}
