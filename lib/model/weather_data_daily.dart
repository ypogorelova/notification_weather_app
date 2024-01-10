import 'package:weather_app/utils/icons.dart';

class WeatherDataDaily {
  List<Daily> daily;

  WeatherDataDaily({required this.daily});

  factory WeatherDataDaily.fromJson(Map<String, dynamic> json) =>
      WeatherDataDaily(
          daily: List<Daily>.from(
              json['DailyForecasts'].map((e) => Daily.fromJson(e))));
}

class Temp {
  int? min;
  int? max;
  int? feelsLikeMin;
  int? feelsLikeMax;
  int? feelsLikeShadeMin;
  int? feelsLikeShadeMax;

  Temp(
      {this.min,
      this.max,
      this.feelsLikeMin,
      this.feelsLikeMax,
      this.feelsLikeShadeMin,
      this.feelsLikeShadeMax});

  factory Temp.fromJson(Map<String, dynamic> json) => Temp(
        min: (json['Temperature']['Minimum']['Value'] as num?)?.round(),
        max: (json['Temperature']['Maximum']['Value'] as num?)?.round(),
        feelsLikeMin:
            (json['RealFeelTemperature']['Minimum']['Value'] as num?)?.round(),
        feelsLikeMax:
            (json['RealFeelTemperature']['Maximum']['Value'] as num?)?.round(),
        feelsLikeShadeMin:
            (json['RealFeelTemperatureShade']['Minimum']['Value'] as num?)
                ?.round(),
        feelsLikeShadeMax:
            (json['RealFeelTemperatureShade']['Maximum']['Value'] as num?)
                ?.round(),
      );

  Map<String, dynamic> toJson() => {
        'min': min,
        'max': max,
        'feelsLikeMin': feelsLikeMin,
        'feelsLikeMax': feelsLikeMax,
        'feelsLikeShadeMin': feelsLikeShadeMin,
        'feelsLikeShadeMax': feelsLikeShadeMax,
      };
}

class AirAndPollen {
  String? name;
  int? value;
  String? category;

  AirAndPollen({
    this.name,
    this.value,
    this.category,
  });

  factory AirAndPollen.fromJson(Map<String, dynamic> json) => AirAndPollen(
        name: (json['Name'] as String?),
        value: (json['Value'] as num?)?.round(),
        category: (json['Category'] as String?),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'value': value,
        'category': category,
      };
}

class Daily {
  int? dt;
  Temp? temp;
  double? hoursOfSun;
  String? sunrise;
  String? sunset;
  String? moonrise;
  String? moonset;
  List<AirAndPollen>? airQuality;
  Day? day;
  Night? night;

  Daily({
    this.dt,
    this.temp,
    this.hoursOfSun,
    this.sunrise,
    this.sunset,
    this.moonrise,
    this.moonset,
    this.airQuality,
    this.day,
    this.night,
  });

  factory Daily.fromJson(Map<String, dynamic> json) {
    var airQualityList = json['AirAndPollen'] as List;
    List<AirAndPollen> airQuality =
        airQualityList.map((e) => AirAndPollen.fromJson(e)).toList();

    return Daily(
      dt: json['EpochDate'] as int,
      temp: Temp.fromJson(json),
      hoursOfSun: json['HoursOfSun'] as double,
      sunrise: json['Sun']['Rise'] as String,
      sunset: json['Sun']['Set'] as String,
      moonrise: json['Moon']['Rise'] as String,
      moonset: json['Moon']['Set'] as String,
      day: Day.fromJson(json),
      night: Night.fromJson(json),
      airQuality: airQuality,
    );
  }

  Map<String, dynamic> toJson() => {
        'dt': dt,
        'hoursOfSun': hoursOfSun,
        'sunrise': sunrise,
        'sunset': sunset,
        'moonrise': moonrise,
        'moonset': moonset,
        'temp': temp?.toJson(),
        'day': day?.toJson(),
        'night': night?.toJson(),
      };
}

class Day {
  String? icon;
  String? description;
  double? windSpeed;
  int? thunderProb;
  int? rainProb;
  int? snowProb;
  int? iceProb;
  int? cloudCover;
  bool? hasPrecipitation;

  Day(
      {this.icon,
      this.description,
      this.windSpeed,
      this.thunderProb,
      this.rainProb,
      this.snowProb,
      this.iceProb,
      this.cloudCover,
      this.hasPrecipitation});

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        icon: (icons[json['Day']['Icon'] as int?]),
        description: (json['Day']['ShortPhrase'] as String?),
        windSpeed: (json['Day']['Wind']['Speed']['Value'] as double?),
        thunderProb: (json['Day']['ThunderstormProbability'] as int?),
        rainProb: (json['Day']['RainProbability'] as int?),
        snowProb: (json['Day']['SnowProbability'] as int?),
        iceProb: (json['Day']['IceProbability'] as int?),
        cloudCover: (json['Day']['CloudCover'] as int?),
        hasPrecipitation: (json['Day']['HasPrecipitation'] as bool?),
      );

  Map<String, dynamic> toJson() => {
        'icon': icon,
        'description': description,
        'windSpeed': windSpeed,
        'thunderProb': thunderProb,
        'rainProb': rainProb,
        'snowProb': snowProb,
        'iceProb': iceProb,
        'cloudCover': cloudCover,
        'hasPrecipitation': hasPrecipitation,
      };
}

class Night {
  String? icon;
  String? description;
  double? windSpeed;
  int? thunderProb;
  int? rainProb;
  int? snowProb;
  int? iceProb;
  int? cloudCover;
  bool? hasPrecipitation;

  Night({
    this.icon,
    this.description,
    this.windSpeed,
    this.thunderProb,
    this.rainProb,
    this.snowProb,
    this.iceProb,
    this.cloudCover,
    this.hasPrecipitation,
  });

  factory Night.fromJson(Map<String, dynamic> json) => Night(
        icon: (icons[json['Night']['Icon'] as int?]),
        description: (json['Night']['ShortPhrase'] as String?),
        windSpeed: (json['Night']['Wind']['Speed']['Value'] as double?),
        thunderProb: (json['Night']['ThunderstormProbability'] as int?),
        rainProb: (json['Night']['RainProbability'] as int?),
        snowProb: (json['Night']['SnowProbability'] as int?),
        iceProb: (json['Night']['IceProbability'] as int?),
        cloudCover: (json['Night']['CloudCover'] as int?),
        hasPrecipitation: (json['Night']['HasPrecipitation'] as bool?),
      );

  Map<String, dynamic> toJson() => {
        'icon': icon,
        'description': description,
        'windSpeed': windSpeed,
        'thunderProb': thunderProb,
        'rainProb': rainProb,
        'snowProb': snowProb,
        'iceProb': iceProb,
        'cloudCover': cloudCover,
        'hasPrecipitation': hasPrecipitation,
      };
}
