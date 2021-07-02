import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/weather_bloc.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/gradientIcon.dart';
import 'package:weather_app/pages/home_page.dart';

import 'detail_info_item.dart';

class SuggestItem extends StatelessWidget {
  final Weather weather;

  SuggestItem({Key key, @required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<WeatherBloc>(context).changeTabController.add(0);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
        width: 180,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).cardColor),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (() {
                // your code here
                if (this.weather.temp != null) {
                  return Text(
                    "${this.weather.temp.round()}°C",
                    style: Theme.of(context).textTheme.headline5,
                  );
                } else {
                  return SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator());
                }
              }()),
              GradientIcon(
                  icon: Icon(
                Icons.cloud,
                size: 50,
              ))
            ],
          ),
          SizedBox(
            height: 60,
            child: Text(
              this.weather.location,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          (() {
            // your code here
            if (this.weather.timezone != null) {
              return Text(
                this.weather.timezone,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.blueGrey[600]),
              );
            } else {
              return SizedBox(
                  width: 20, height: 20, child: CircularProgressIndicator());
            }
          }()),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              (() {
                // your code here
                if (this.weather.humidity != null) {
                  return DetailInfoItem(
                    icon: Icon(
                      Icons.grain,
                      size: 17,
                      color: Colors.blueGrey[600],
                    ),
                    title: "${this.weather.humidity.toString()} %",
                    fontSize: 14,
                    margin: EdgeInsets.only(right: 5),
                  );
                } else {
                  return SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator());
                }
              }()),
              (() {
                // your code here
                if (this.weather.windSpeed != null) {
                  return DetailInfoItem(
                    icon: Icon(
                      Icons.stacked_line_chart,
                      size: 14,
                      color: Colors.blueGrey[600],
                    ),
                    title: "${this.weather.windSpeed.round()} km/h",
                    fontSize: 14,
                    margin: EdgeInsets.only(right: 5),
                  );
                } else {
                  return SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator());
                }
              }()),
            ],
          )
        ]),
      ),
    );
  }
}
