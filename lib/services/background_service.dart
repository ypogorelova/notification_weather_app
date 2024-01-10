import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/api/fetch_weather.dart';
import 'package:weather_app/controller/global.dart';

import 'notification_service.dart';

class BackgroundService {
  // Singleton pattern
  static final BackgroundService _service = BackgroundService._internal();

  factory BackgroundService() {
    return _service;
  }

  BackgroundService._internal();

  final bgServicePlugin = FlutterBackgroundService();

  Future<void> init() async {
    await bgServicePlugin.configure(
      androidConfiguration: AndroidConfiguration(
        // this will be executed when app is in foreground or background in separated isolate
        onStart: onStart,

        // auto start service
        autoStart: true,
        isForegroundMode: false,
      ),
      iosConfiguration: IosConfiguration(
        // auto start service
        autoStart: true,

        // this will be executed when app is in foreground in separated isolate
        onForeground: onStart,

        // you have to enable background fetch capability on xcode project
        onBackground: onIosBackground,
      ),
    );
  }
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.reload();
  print('FLUTTER BACKGROUND SERVICE[iosBG]: ${DateTime.now()}');
  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();

  final NotificationService notificationService = NotificationService();
  final GlobalController globalController = Get.put(GlobalController());

  // bring to foreground
  Timer.periodic(const Duration(hours: 1), (timer) async {
    print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');
    if (globalController.checkLoading().isFalse) {
      final currentWeather =
          await FetchWeatherAPI().processData(globalController.getKey());
      // get current wet bulb temperature
      final wetBulbTemp = currentWeather.current?.current.wetBulbTemp;
      // wet bulb temperature threshold
      if (wetBulbTemp! >= 95) {
        await notificationService.showNotification(
          0,
          'Wet Bulb temperature alert',
          "Wet Bulb temperature $wetBulbTemp is higher than recommended",
          jsonEncode({
            "title": "Default_Sound",
            "eventDate": "Default_Sound",
            "eventTime": "Default_Sound",
          }),
        );
      }
    }
  });
}
