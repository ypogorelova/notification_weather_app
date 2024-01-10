import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_data_daily.dart';
import 'package:weather_app/screens/daily_details.dart';
import 'package:weather_app/utils/custom_colors.dart';
import 'package:weather_app/utils/helpers.dart';

class DailyDataForecast extends StatelessWidget {
  final WeatherDataDaily weatherDataDaily;

  const DailyDataForecast({Key? key, required this.weatherDataDaily})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: CustomColors.dividerLine.withAlpha(150),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(bottom: 10),
            child: const Text(
              "Next Days",
              style:
                  TextStyle(color: CustomColors.textColorBlack, fontSize: 17),
            ),
          ),
          dailyList(),
        ],
      ),
    );
  }

  Widget dailyList() {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: weatherDataDaily.daily.length > 5
            ? 5
            : weatherDataDaily.daily.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DailyWeatherMoreDetailsWidget(
                      weatherDataDaily: weatherDataDaily, index: index),
                ),
              );
            },
            child: Column(
              children: [
                Container(
                    height: 60,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 80,
                          child: Text(
                            getDay(weatherDataDaily.daily[index].dt),
                            style: const TextStyle(
                                color: CustomColors.textColorBlack,
                                fontSize: 13),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: Image.asset(
                              "assets/weather/${weatherDataDaily.daily[index].day?.icon}.png"),
                        ),
                        Text(
                            "${weatherDataDaily.daily[index].temp?.max}F/${weatherDataDaily.daily[index].temp?.min} F"),
                      ],
                    )),
                Container(
                  height: 1,
                  color: CustomColors.dividerLine,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
