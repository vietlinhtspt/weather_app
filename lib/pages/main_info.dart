import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';

class MainInfo extends StatelessWidget {
  final Weather weather;
  const MainInfo({Key key, @required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 80),
          Text(
            this.weather.location,
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            "${this.weather.temp.round().toString()}°",
            style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 60),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
                color: Colors.deepPurple[900],
                borderRadius: BorderRadius.circular(20)),
            child: Text(
              this.weather.formattedCondition,
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
