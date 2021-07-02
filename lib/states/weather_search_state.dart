import 'package:flutter/cupertino.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/states/weather_state.dart';

class WeatherStateSearchSuccess extends WeatherState {
  final List<Weather> weathers;
  const WeatherStateSearchSuccess({@required this.weathers})
      : assert(weathers != null);

  @override
  List<List<Object>> get props => [weathers];
}

class WeatherStateSearchInitial extends WeatherState {}

class WeatherStateSearchLoading extends WeatherState {}

class WeatherStateSearchFailure extends WeatherState {}
