import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/setting_bloc.dart';
import 'package:weather_app/blocs/weather_bloc.dart';
import 'package:weather_app/pages/detail_info.dart';
import 'package:weather_app/pages/gradient_icon.dart';
import 'package:weather_app/pages/main_info.dart';
import 'package:weather_app/pages/sun_info.dart';
import 'package:weather_app/pages/today_info.dart';
import 'package:weather_app/pages/weather_picture.dart';
import 'package:weather_app/states/setting_state.dart';
import 'package:weather_app/states/weather_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> weekInfo = [
    "Monday",
    "Tueday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, weatherState) {
      if (weatherState is WeatherStateInitial) {
        return Expanded(
          child: Center(
            child: Text("Please select a location first"),
          ),
        );
      } else if (weatherState is WeatherStateLoading) {
        return SizedBox(
            height: 100, child: Center(child: CircularProgressIndicator()));
      } else if (weatherState is WeatherStateSuccess) {
        return BlocBuilder<SettingBloc, SettingState>(
          builder: (context, settingState) {
            return Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Stack(children: [
                WeatherPicture(),
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MainInfo(
                            weather: weatherState.weather,
                            setting: settingState.setting),
                        SizedBox(height: 50),
                        DetailInfo(
                          weather: weatherState.weather,
                          setting: settingState.setting,
                        ),
                        SizedBox(height: 50),
                        SunInfo(),
                        SizedBox(height: 50),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 21, vertical: 10),
                          child: Text(
                            "Today",
                            style: TextStyle(
                                color: Colors.blueGrey[600],
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        TodayInfo(),
                        Column(
                          children: this.weekInfo.map((item) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 19),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 150,
                                    child: Text(
                                      item,
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                  ),
                                  GradientIcon(icon: Icon(Icons.circle)),
                                  Container(
                                    child: Row(
                                      children: [
                                        Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              "19°",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5,
                                            )),
                                        Text(
                                          "15°",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }).toList(),
                        )
                      ]),
                )
              ]),
            );
          },
        );
      }
      return Text(
        'Something went wrong',
        style: TextStyle(color: Colors.redAccent, fontSize: 16),
      );
    });
  }
}
