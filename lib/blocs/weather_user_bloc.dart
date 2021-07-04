import 'dart:async';

import "package:flutter_bloc/flutter_bloc.dart";
import 'package:weather_app/events/weather_event.dart';
import 'package:weather_app/events/weather_user_event.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/states/weather_state.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:flutter/cupertino.dart';

class WeatherUserBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherServices weatherServices;
  WeatherUserBloc({@required this.weatherServices})
      : assert(weatherServices != null),
        super(WeatherStateInitial());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is WeatherUserEventRequest) {
      yield WeatherStateLoading();
      try {
        final Weather weather =
            await weatherServices.locationSearch(event.latt, event.long);
        yield WeatherStateSuccess(weather: weather);
      } catch (e) {
        yield WeatherStateFailure();
      }
    } else if (event is WeatherUserEventRefresh) {
      yield WeatherStateLoading();
      try {
        Weather weather = await weatherServices.fetchWeather(event.woeid);
        yield WeatherStateSuccess(weather: weather);
      } catch (e) {
        yield WeatherStateFailure();
      }
    }
  }
}
