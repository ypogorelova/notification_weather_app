import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controller/global.dart';
import 'package:weather_app/screens/home.dart';
import 'services/notification_service.dart';
import 'services/background_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(GlobalController());
  BackgroundService bgService = BackgroundService();
  await bgService.init();
  NotificationService notificationService = NotificationService();
  await notificationService.init();
  await notificationService.requestIOSPermissions();
  await notificationService.requestAndroidPermissions();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: HomeScreen(),
      title: "Weather",
      debugShowCheckedModeBanner: false,
    );
  }
}
