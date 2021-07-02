import "package:flutter_bloc/flutter_bloc.dart";
import 'package:weather_app/events/weather_search_event.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/states/weather_search_state.dart';
import 'package:weather_app/states/weather_state.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:flutter/cupertino.dart';

class WeatherSearchBloc extends Bloc<WeatherSearchEvent, WeatherState> {
  final WeatherServices weatherServices;
  WeatherSearchBloc({@required this.weatherServices})
      : assert(weatherServices != null),
        super(WeatherStateSearchInitial());

  @override
  Stream<WeatherState> mapEventToState(WeatherSearchEvent event) async* {
    if (event is WeatherSearchEventSearch) {
      yield WeatherStateSearchLoading();
      try {
        final List<Weather> weathers =
            await weatherServices.searchCity(event.city);
        yield WeatherStateSearchSuccess(weathers: weathers);
        List<Weather> fullInfo = [];
        for (var weather in weathers) {
          fullInfo += [await weatherServices.fetchWeather(weather.locationId)];
        }
        yield WeatherStateSearchSuccess(weathers: fullInfo);
      } catch (e) {
        yield WeatherStateSearchFailure();
      }
    }
  }
}
