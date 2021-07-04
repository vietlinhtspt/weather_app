import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/weather_bloc.dart';
import 'package:weather_app/blocs/weather_user_bloc.dart';
import 'package:weather_app/events/weather_event.dart';
import 'package:tiengviet/tiengviet.dart';
import 'package:weather_app/events/weather_user_event.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/detail_info.dart';
import 'package:weather_app/pages/gradientIcon.dart';
import 'package:weather_app/pages/setting_item.dart';
import 'package:weather_app/states/weather_state.dart';
import 'package:location/location.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key key}) : super(key: key) {
    this.getLocation();
  }

  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  Future<LocationData> getLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return location.getLocation();
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.DENIED) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.GRANTED) {
        return location.getLocation();
      }
    }

    return await location.getLocation();
  }

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  LocationData locationData;
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    locationData = await widget.getLocation();
    setState(() {
      locationData = locationData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherUserBloc, WeatherState>(
      builder: (context, weatherUserState) {
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (() {
                if (weatherUserState is WeatherStateSuccess) {
                  return WeatherUserInfo(weather: weatherUserState.weather);
                } else if (weatherUserState is WeatherStateInitial) {
                  // Future<LocationData> locationData = widget.getLocation();
                  // setState(() {
                  //   widget.locationData = widget.getLocation() as LocationData;
                  // });
                  // print(locationData);
                  if (this.locationData != null) {
                    BlocProvider.of<WeatherUserBloc>(context).add(
                        WeatherUserEventRequest(
                            latt: this.locationData.latitude.toDouble(),
                            long: this.locationData.longitude.toDouble()));
                  }
                  return Expanded(
                    child: Center(
                      child: Text("Finding your location..."),
                    ),
                  );
                } else if (weatherUserState is WeatherStateLoading) {
                  return SizedBox(
                      height: 100,
                      child: Center(child: CircularProgressIndicator()));
                } else {
                  return Text(
                    'Something went wrong',
                    style: TextStyle(color: Colors.redAccent, fontSize: 16),
                  );
                }
              }()),
              SettingItem(
                title: "Temperature",
                meansure: "Celcius",
                optionNames: [
                  "Celcius",
                  "Fahrenheit",
                ],
              ),
              SettingItem(
                title: "Wind Speed",
                meansure: "m/s",
                optionNames: [
                  "m/s",
                  "km/h",
                ],
              ),
              SettingItem(
                title: "Source",
                meansure: "weather.gov",
                optionNames: ["weather.gov", "weather.vn", "weather.com"],
              )
            ],
          ),
        );
      },
    );
  }
}

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

class UserLocation extends StatelessWidget {
  final Weather weather;
  const UserLocation({Key key, this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(TiengViet.parse("Hà Nội"));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              color: Colors.grey,
            ),
            Text(
              "Your Location Now",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            )
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 10)),
        Column(
          children: [
            Text(
              "${this.weather.location}, ${this.weather.timezone}",
              style: Theme.of(context).textTheme.headline6,
            )
          ],
        )
      ],
    );
  }
}
