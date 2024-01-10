import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/model/weather_data_daily.dart';
import 'package:weather_app/utils/custom_colors.dart';
import 'package:weather_app/utils/helpers.dart';
import 'package:weather_app/widgets/details_widget.dart';
import 'package:weather_app/widgets/temperature_weather_widget.dart';

class DailyWeatherMoreDetailsWidget extends StatelessWidget {
  final WeatherDataDaily weatherDataDaily;
  final int index;

  const DailyWeatherMoreDetailsWidget(
      {Key? key, required this.weatherDataDaily, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Details"),
      ),
      body: SafeArea(
        bottom: false,
        minimum: const EdgeInsets.all(16.0),
        child: Center(child: buildBody()),
      ),
    );
  }

  Widget buildBody() {
    Container horizontalDivider = buildHorizontalDivider();
    Container verticalDivider = buildVerticalDivider();

    Container date = Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      alignment: Alignment.topLeft,
      child: Text(
        getWeekDayAndDate(weatherDataDaily.daily[index].dt),
        style: TextStyle(fontSize: 14, color: Colors.grey[700], height: 1.5),
      ),
    );

    Widget detailsDayNightList(double? windSpeed, int? snowProb, int? rainProb,
        int? iceProb, int? thunderProb) {
      return SizedBox(
          child: Column(
        children: [
          buildDetailsContainer(
              "Wind speed",
              "$windSpeed mi/h",
              const Icon(
                FontAwesomeIcons.wind,
                color: Colors.blue,
                size: 15.0,
              )),
          buildDetailsDivider(),
          buildDetailsContainer(
              "Snow probability",
              "$snowProb %",
              const Icon(
                FontAwesomeIcons.snowflake,
                color: Colors.blue,
                size: 15.0,
              )),
          buildDetailsDivider(),
          buildDetailsContainer(
              "Rain probability",
              "$rainProb %",
              const Icon(
                FontAwesomeIcons.cloudRain,
                color: Colors.blue,
                size: 15.0,
              )),
          buildDetailsDivider(),
          buildDetailsContainer(
              "Ice probability",
              "$iceProb %",
              const Icon(
                FontAwesomeIcons.icicles,
                color: Colors.blue,
                size: 15.0,
              )),
          buildDetailsDivider(),
          buildDetailsContainer(
              "Thunder probability",
              "$thunderProb %",
              const Icon(
                FontAwesomeIcons.boltLightning,
                color: Colors.blue,
                size: 15.0,
              )),
        ],
      ));
    }

    Widget detailsSunMoon(double? hoursOfSun, String? sunrise, String? sunset,
        String? moonrise, String? moonset) {
      return SizedBox(
          child: Column(
        children: [
          buildDetailsContainer(
              "Hours of sun",
              "$hoursOfSun",
              Image.asset(
                "assets/icons/sun.png",
                color: Colors.blue,
              )),
          buildDetailsDivider(),
          buildDetailsContainer(
              "Sun rise",
              getTime(sunrise),
              Image.asset(
                "assets/icons/sun_rise.png",
                color: Colors.blue,
              )),
          buildDetailsDivider(),
          buildDetailsContainer(
              "Sun set",
              getTime(sunset),
              Image.asset(
                "assets/icons/sun_set.png",
                color: Colors.blue,
              )),
          buildDetailsDivider(),
          buildDetailsContainer("Moon rise", getTime(moonrise),
              Image.asset("assets/icons/moon_rise.png", color: Colors.blue)),
          buildDetailsDivider(),
          buildDetailsContainer("Moon set", getTime(moonset),
              Image.asset("assets/icons/moon_set_.png", color: Colors.blue)),
        ],
      ));
    }

    Widget airAndPollenDetails(items) {
      final divider = buildHorizontalDivider();
      return SizedBox(
        child: Column(
          children: [
            for (AirAndPollen item in items) ...[
              buildDetailsContainer(
                  item.name, ('${item.value} ${item.category}'), null),
              divider,
            ]
          ],
        ),
      );
    }

    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            date,
            verticalDivider,
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              alignment: Alignment.topLeft,
              child: Text("Day",
                  style: TextStyle(
                      fontSize: 14, color: Colors.grey[700], height: 1.5)),
            ),
          ],
        ),
        TemperatureWeatherWidget(
          weatherIcon: weatherDataDaily.daily[index].day?.icon,
          temp: weatherDataDaily.daily[index].temp?.max,
          feelsLike: weatherDataDaily.daily[index].temp?.feelsLikeMax,
          feelsLikeShade: weatherDataDaily.daily[index].temp?.feelsLikeShadeMax,
          weatherDescription: weatherDataDaily.daily[index].day?.description,
        ),
        Container(
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
                  "Day Details",
                  style: TextStyle(
                      color: CustomColors.textColorBlack, fontSize: 17),
                ),
              ),
              detailsDayNightList(
                  weatherDataDaily.daily[index].day?.windSpeed,
                  weatherDataDaily.daily[index].day?.snowProb,
                  weatherDataDaily.daily[index].day?.rainProb,
                  weatherDataDaily.daily[index].day?.iceProb,
                  weatherDataDaily.daily[index].day?.thunderProb)
            ],
          ),
        ),
        horizontalDivider,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            date,
            verticalDivider,
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              alignment: Alignment.topLeft,
              child: Text("Night",
                  style: TextStyle(
                      fontSize: 14, color: Colors.grey[700], height: 1.5)),
            ),
          ],
        ),
        TemperatureWeatherWidget(
          weatherIcon: weatherDataDaily.daily[index].night?.icon,
          temp: weatherDataDaily.daily[index].temp?.min,
          feelsLike: weatherDataDaily.daily[index].temp?.feelsLikeMin,
          weatherDescription: weatherDataDaily.daily[index].night?.description,
        ),
        Container(
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
                  "Night Details",
                  style: TextStyle(
                      color: CustomColors.textColorBlack, fontSize: 17),
                ),
              ),
              detailsDayNightList(
                  weatherDataDaily.daily[index].night?.windSpeed,
                  weatherDataDaily.daily[index].night?.snowProb,
                  weatherDataDaily.daily[index].night?.rainProb,
                  weatherDataDaily.daily[index].night?.iceProb,
                  weatherDataDaily.daily[index].night?.thunderProb)
            ],
          ),
        ),
        horizontalDivider,
        detailsSunMoon(
            weatherDataDaily.daily[index].hoursOfSun,
            weatherDataDaily.daily[index].sunrise,
            weatherDataDaily.daily[index].sunset,
            weatherDataDaily.daily[index].moonrise,
            weatherDataDaily.daily[index].moonset),
        horizontalDivider,
        airAndPollenDetails(weatherDataDaily.daily[index].airQuality),
      ],
    );
  }

  Container buildHorizontalDivider() {
    Container horizontalDivider = Container(
      height: 1,
      color: CustomColors.dividerLine,
    );
    return horizontalDivider;
  }

  Container buildVerticalDivider() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      alignment: Alignment.topLeft,
      height: 15,
      width: 1,
      color: CustomColors.dividerLine,
    );
  }
}
