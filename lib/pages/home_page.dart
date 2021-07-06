import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:weather_app/blocs/setting_bloc.dart';
import 'package:weather_app/blocs/weather_bloc.dart';
import 'package:weather_app/events/weather_event.dart';
import 'package:weather_app/models/setting_model.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/detail_info.dart';
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
  Weather storedweather;

  void addItem(Weather item) {
    var box = Hive.box<Weather>('weather');
    if (box.isNotEmpty) {
      box.putAt(0, item);
    } else {
      box.add(item);
    }
  }

  void getItem() async {
    final box = await Hive.openBox<Weather>('weather');
    if (box != null) {
      if (box.isNotEmpty) {
        storedweather = box.getAt(0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, weatherState) {
      if (weatherState is WeatherStateInitial) {
        getItem();
        if (this.storedweather != null) {
          BlocProvider.of<WeatherBloc>(context)
              .add(WeatherEventSet(weather: storedweather));
        }
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
            addItem(weatherState.weather);
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
                        (() {
                          if (weatherState.weather.futureWeathers != null) {
                            return Column(
                                children: weatherState.weather.futureWeathers
                                    .map((weekWeatherItem) {
                              return WeekItemInfo(
                                futureWeather: weekWeatherItem,
                                setting: settingState.setting,
                              );
                            }).toList());
                          } else {
                            return SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator());
                          }
                        }())
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

class WeekItemInfo extends StatelessWidget {
  final List<String> days = [
    "Monday",
    "Tueday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
  final FutureWeather futureWeather;
  final Setting setting;
  WeekItemInfo({Key key, this.futureWeather, this.setting}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 19),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 150,
            child: Text(
              this.days[this.futureWeather.dateTime.weekday - 1],
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          (() {
            // your code here
            if (this.futureWeather.formattedCondition != null) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                decoration: BoxDecoration(
                    color: Colors.deepPurple[900],
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  this.futureWeather.formattedCondition,
                  style: TextStyle(fontSize: 8, color: Colors.white),
                ),
              );
            } else {
              return SizedBox(
                  width: 20, height: 20, child: CircularProgressIndicator());
            }
          }()),
          Container(
            child: Row(
              children: [
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      formatedTemperature(this.futureWeather.maxTemp.round(),
                          this.setting.temperatureMeansure),
                      style: Theme.of(context).textTheme.headline5,
                    )),
                Text(
                  formatedTemperature(this.futureWeather.minTemp.round(),
                      this.setting.temperatureMeansure),
                  style: Theme.of(context).textTheme.headline6,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
