import 'package:flutter/material.dart';
import 'package:weather_app/utils/custom_colors.dart';

class TemperatureWeatherWidget extends StatelessWidget {
  final String? weatherIcon;
  final int? temp;
  final int? feelsLike;
  final int? feelsLikeShade;
  final String? weatherDescription;

  const TemperatureWeatherWidget(
      {Key? key,
      this.weatherIcon,
      this.temp,
      this.feelsLike,
      this.feelsLikeShade,
      this.weatherDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: <Widget>[
            RichText(
              text: TextSpan(
                text: weatherDescription ?? "",
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              "assets/weather/$weatherIcon.png",
              height: 80,
              width: 80,
            ),
            Container(
              height: 50,
              width: 1,
              color: CustomColors.dividerLine,
            ),
            RichText(
              text: TextSpan(
                  text: "$temp F",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 68,
                    color: CustomColors.textColorBlack,
                  )),
            ),
          ],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: "Feels like $feelsLike F",
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.grey,
                  )),
              const WidgetSpan(
                child: SizedBox(width: 15),
              ),
              TextSpan(
                  text: feelsLikeShade != null
                      ? "Feels like in shade $feelsLikeShade F"
                      : "",
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.grey,
                  )),
            ]),
          )
        ]),
      ],
    );
  }
}
