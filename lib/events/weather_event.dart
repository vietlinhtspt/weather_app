import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_app/models/weather_model.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class WeatherEventRequest extends WeatherEvent {
  final String city;
  const WeatherEventRequest({@required this.city}) : assert(city != null);
  @override
  List<Object> get props => [city];
}

class WeatherEventRefresh extends WeatherEvent {
  final String city;
  const WeatherEventRefresh({@required this.city});
  @override
  List<Object> get props => [city];
}

class WeatherEventSearch extends WeatherEvent {
  final String city;
  const WeatherEventSearch({@required this.city});
  @override
  List<Object> get props => [city];
}

class WeatherEventSet extends WeatherEvent {
  final Weather weather;
  const WeatherEventSet({@required this.weather});
  @override
  List<Object> get props => [weather];
}
