import 'package:weather_app/api/api_key.dart';

String locationKeybyCityURL(var city) {
  String url;

  url =
      "http://dataservice.accuweather.com/locations/v1/cities/search?apikey=$apiKey&q=$city";
  return url;
}

String locationKeybyGeoURL(var lat, var lon) {
  String url;

  url =
      "http://dataservice.accuweather.com/locations/v1/cities/search?apikey=$apiKey&q=$lat,$lon";
  return url;
}

String currentWeatherURL(var city) {
  String url;

  url =
      "http://dataservice.accuweather.com/currentconditions/v1/$city?apikey=$apiKey&details=true";
  return url;
}

String dailyWeatherURL(var city) {
  String url;

  url =
      "http://dataservice.accuweather.com/forecasts/v1/daily/5day/$city?apikey=$apiKey&details=true";
  return url;
}

String hourlyWeatherURL(var city) {
  String url;

  url =
      "http://dataservice.accuweather.com/forecasts/v1/hourly/12hour/$city?apikey=$apiKey&details=true";
  return url;
}
