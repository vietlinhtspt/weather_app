import 'package:flutter/material.dart';
import 'package:weather_app/models/setting_model.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/detail_info_item.dart';

class DetailInfo extends StatelessWidget {
  final Weather weather;
  final Setting setting;
  const DetailInfo({Key key, @required this.weather, @required this.setting})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        (() {
          // your code here
          if (this.weather.humidity != null) {
            return DetailInfoItem(
              icon: Icon(
                Icons.grain,
                color: Colors.blueGrey[600],
                size: 30,
              ),
              title: "${this.weather.humidity.toString()} %",
            );
          } else {
            return SizedBox(
                width: 20, height: 20, child: CircularProgressIndicator());
          }
        }()),
        (() {
          // your code here
          if (this.weather.airPressure != null) {
            return DetailInfoItem(
              icon: Icon(
                Icons.lock_clock,
                color: Colors.blueGrey[600],
                size: 30,
              ),
              title: "${this.weather.airPressure.round().toString()} Bar",
            );
          } else {
            return SizedBox(
                width: 20, height: 20, child: CircularProgressIndicator());
          }
        }()),
        (() {
          // your code here
          if (this.weather.windSpeed != null) {
            return DetailInfoItem(
              icon: Icon(
                Icons.stacked_line_chart,
                color: Colors.blueGrey[600],
                size: 30,
              ),
              title: formatedWindSpeed(this.weather.windSpeed.round(),
                  this.setting.windSpeedMeansure),
            );
          } else {
            return SizedBox(
                width: 20, height: 20, child: CircularProgressIndicator());
          }
        }()),
      ],
    );
  }
}
