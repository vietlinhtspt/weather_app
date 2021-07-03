import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/detail_info_item.dart';

class DetailInfo extends StatelessWidget {
  final Weather weather;
  const DetailInfo({Key key, this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        DetailInfoItem(
          icon: Icon(
            Icons.grain,
            color: Colors.blueGrey[600],
            size: 30,
          ),
          title: "${this.weather.humidity.toString()} %",
        ),
        DetailInfoItem(
          icon: Icon(
            Icons.lock_clock,
            color: Colors.blueGrey[600],
            size: 30,
          ),
          title: "${this.weather.airPressure.round().toString()} Bar",
        ),
        DetailInfoItem(
          icon: Icon(
            Icons.stacked_line_chart,
            color: Colors.blueGrey[600],
            size: 30,
          ),
          title: "${this.weather.windSpeed.round().toString()} km/h",
        )
      ],
    );
  }
}
