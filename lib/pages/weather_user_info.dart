import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/detail_info.dart';
import 'package:weather_app/pages/gradientIcon.dart';
import 'package:weather_app/pages/user_location.dart';

class WeatherUserInfo extends StatelessWidget {
  final Weather weather;
  const WeatherUserInfo({Key key, @required this.weather})
      : assert(weather != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserLocation(weather: weather),
        Container(
          margin: EdgeInsets.all(20),
          child: GradientIcon(
              icon: Icon(
            Icons.circle,
            size: 170,
          )),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.deepPurple[600]),
          child: Text(
            "${this.weather.formattedCondition}",
            style:
                TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 15),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          child: Text(
            "${this.weather.temp.round()}°C",
            style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 50),
          ),
        ),
        DetailInfo(
          weather: weather,
        )
      ],
    );
  }
}
