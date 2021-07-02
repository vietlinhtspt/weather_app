import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class WeatherSearchEvent extends Equatable {
  const WeatherSearchEvent();
}

class WeatherSearchEventSearch extends WeatherSearchEvent {
  final String city;
  const WeatherSearchEventSearch({@required this.city});
  @override
  List<Object> get props => [city];
}
