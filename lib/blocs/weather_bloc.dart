import 'dart:async';

import "package:flutter_bloc/flutter_bloc.dart";
import 'package:weather_app/events/weather_event.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/states/weather_state.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:flutter/cupertino.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherServices weatherServices;
  WeatherBloc({@required this.weatherServices})
      : assert(weatherServices != null),
        super(WeatherStateInitial());

  StreamController<int> changeTabController = StreamController<int>.broadcast();
  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is WeatherEventRequest) {
      yield WeatherStateLoading();
      try {
        final Weather weather =
            await weatherServices.getWeatherFromCity(event.city);
        yield WeatherStateSuccess(weather: weather);
      } catch (e) {
        yield WeatherStateFailure();
      }
    } else if (event is WeatherEventRefresh) {
      yield WeatherStateLoading();
      try {
        Weather weather = await weatherServices.getWeatherFromCity(event.city);
        yield WeatherStateSuccess(weather: weather);
      } catch (e) {
        yield WeatherStateFailure();
      }
    }
  }

  @override
  Future<void> close() {
    changeTabController.close();
    return super.close();
  }
}
