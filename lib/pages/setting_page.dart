import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/setting_bloc.dart';
import 'package:weather_app/blocs/weather_user_bloc.dart';
import 'package:weather_app/events/setting_event.dart';
import 'package:weather_app/events/weather_user_event.dart';
import 'package:weather_app/models/setting_model.dart';
import 'package:weather_app/pages/setting_item.dart';
import 'package:weather_app/pages/weather_user_info.dart';
import 'package:weather_app/states/setting_state.dart';
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

  List<String> enumToList<T>(List<T> enumValues, var formatedValues) {
    List<String> listValues = List<String>();
    for (var value in enumValues) {
      listValues.add(formatedValues[value]);
    }
    return listValues;
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
                  return BlocBuilder<SettingBloc, SettingState>(
                    builder: (context, settingState) {
                      return WeatherUserInfo(
                          weather: weatherUserState.weather,
                          setting: settingState.setting);
                    },
                  );
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
              BlocBuilder<SettingBloc, SettingState>(
                builder: (context, settingState) {
                  return SettingItem(
                    title: "Temperature",
                    meansure: formatedTemperatureMeansure[
                        settingState.setting.temperatureMeansure],
                    optionNames: enumToList<TemperatureMeansure>(
                        TemperatureMeansure.values,
                        formatedTemperatureMeansure),
                    defaultIndex:
                        settingState.setting.temperatureMeansure.index,
                    onSelect: (index) {
                      BlocProvider.of<SettingBloc>(context).add(
                          SettingEventUpdate(
                              setting: settingState.setting.copyWithChange(
                                  newTemperatureMeansure:
                                      TemperatureMeansure.values[index])));
                    },
                  );
                },
              ),
              BlocBuilder<SettingBloc, SettingState>(
                builder: (context, settingState) {
                  return SettingItem(
                    title: "Wind Speed",
                    meansure: formatedWindSpeedMeansure[
                        settingState.setting.windSpeedMeansure],
                    optionNames: enumToList<WindSpeedMeansure>(
                        WindSpeedMeansure.values, formatedWindSpeedMeansure),
                    defaultIndex: settingState.setting.windSpeedMeansure.index,
                    onSelect: (index) {
                      BlocProvider.of<SettingBloc>(context).add(
                          SettingEventUpdate(
                              setting: settingState.setting.copyWithChange(
                                  newWindSpeedMeansure:
                                      WindSpeedMeansure.values[index])));
                    },
                  );
                },
              ),
              BlocBuilder<SettingBloc, SettingState>(
                builder: (context, settingState) {
                  return SettingItem(
                    title: "Source",
                    meansure: formatedSourceDataMeansure[
                        settingState.setting.sourceDataMeansure],
                    optionNames: enumToList<SourceDataMeansure>(
                        SourceDataMeansure.values, formatedSourceDataMeansure),
                    defaultIndex: settingState.setting.sourceDataMeansure.index,
                    onSelect: (index) {
                      BlocProvider.of<SettingBloc>(context).add(
                          SettingEventUpdate(
                              setting: settingState.setting.copyWithChange(
                                  newSourceDataMeansure:
                                      SourceDataMeansure.values[index])));
                    },
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
