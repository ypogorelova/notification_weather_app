import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app/api/fetch_weather.dart';
import 'package:weather_app/model/location_data.dart';
import 'package:weather_app/model/weather_data.dart';

class GlobalController extends GetxController {
  final RxBool _isLoading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final RxInt _currentIndex = 0.obs;

  RxBool checkLoading() => _isLoading;

  RxDouble getLatitude() => _latitude;

  RxDouble getLongitude() => _longitude;

  final weatherData = WeatherData().obs;

  WeatherData getData() {
    return weatherData.value;
  }

  final locationKey = LocationKey().obs;

  LocationKey getKey() {
    return locationKey.value;
  }

  @override
  void onInit() {
    if (_isLoading.isTrue) {
      getWeatherByLocation();
    } else {
      getIndex();
    }
    super.onInit();
  }

  getWeatherByLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    // return an error if service is not enabled
    if (!isServiceEnabled) {
      return Future.error("Location not enabled");
    }

    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location permission are denied forever");
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location permission is denied");
      }
    }

    // getting the current position and fetch weather based on position
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      _latitude.value = value.latitude;
      _longitude.value = value.longitude;
      return FetchLocationKeyByGeoAPI()
          .processData(value.latitude, value.longitude)
          .then((value) {
        if (value != null) {
          locationKey.value = value;
          return FetchWeatherAPI().processData(value.key).then((value) {
            weatherData.value = value;
            _isLoading.value = false;
          });
        } else {
          _isLoading.value = true;
        }
      });
    });
  }

  RxInt getIndex() {
    return _currentIndex;
  }
}
