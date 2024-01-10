import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/model/weather_data_current.dart';
import 'package:weather_app/utils/custom_colors.dart';
import 'package:weather_icons/weather_icons.dart';

import 'details_widget.dart';

class CurrentConditions extends StatelessWidget {
  final WeatherDataCurrent weatherDataCurrent;

  const CurrentConditions({Key? key, required this.weatherDataCurrent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              "Today's details",
              style:
                  TextStyle(color: CustomColors.textColorBlack, fontSize: 17),
            ),
          ),
          detailsList(),
        ],
      ),
    );
  }

  Widget detailsList() {
    return SizedBox(
        child: Column(
      children: [
        buildDetailsContainer(
            "Cloud cover",
            "${weatherDataCurrent.current.clouds} %",
            const Icon(
              FontAwesomeIcons.cloud,
              color: Colors.blue,
              size: 15.0,
            )),
        buildDetailsDivider(),
        buildDetailsContainer(
            "Wind speed",
            "${weatherDataCurrent.current.windSpeed} mi/h",
            const Icon(
              FontAwesomeIcons.wind,
              color: Colors.blue,
              size: 15.0,
            )),
        buildDetailsDivider(),
        buildDetailsContainer(
            "UV Index",
            "${weatherDataCurrent.current.uvIndex} ${weatherDataCurrent.current.uvIndexText}",
            SvgPicture.asset("assets/icons/uv-index.svg",
                height: 40.0,
                width: 40.0,
                colorFilter:
                    const ColorFilter.mode(Colors.blue, BlendMode.srcIn))),
        buildDetailsDivider(),
        buildDetailsContainer(
            "Dew Point",
            "${weatherDataCurrent.current.dewPoint} F",
            const Icon(
              IconData(0xf0859, fontFamily: 'MaterialIcons'),
              color: Colors.blue,
              size: 22.0,
            )),
        buildDetailsDivider(),
        buildDetailsContainer(
            "Wet Bulb",
            "${weatherDataCurrent.current.wetBulbTemp} F",
            const BoxedIcon(WeatherIcons.thermometer,
                color: Colors.blue, size: 18.0)),
        buildDetailsDivider(),
        buildDetailsContainer(
            "Pressure",
            "${weatherDataCurrent.current.pressure} inHg",
            const BoxedIcon(WeatherIcons.barometer,
                color: Colors.blue, size: 18.0)),
        buildDetailsDivider(),
        buildDetailsContainer(
            "Humidity",
            "${weatherDataCurrent.current.humidity} %",
            const BoxedIcon(
              WeatherIcons.humidity,
              size: 15.0,
              color: Colors.blue,
            )),
      ],
    ));
  }
}
