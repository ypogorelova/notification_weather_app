import 'package:flutter/material.dart';
import 'package:weather_app/utils/custom_colors.dart';

Container buildDetailsContainer(String? label, String? value, Widget? icon) {
  final iconPart = icon == null
      ? []
      : [
          Container(
              height: 30,
              width: 20,
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: icon)
        ];
  return Container(
      height: 60,
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ...iconPart,
              SizedBox(
                width: 90,
                child: Text(
                  label!,
                  style: const TextStyle(
                      color: CustomColors.textColorBlack, fontSize: 13),
                ),
              ),
            ],
          ),
          SizedBox(child: Text(value!)),
        ],
      ));
}

Container buildDetailsDivider() {
  return Container(
    height: 1,
    color: CustomColors.dividerLine,
  );
}
