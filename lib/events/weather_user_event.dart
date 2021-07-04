import 'package:flutter/cupertino.dart';
import 'package:weather_app/events/weather_event.dart';

class WeatherUserEventRequest extends WeatherEvent {
  final double latt;

  final double long;
  const WeatherUserEventRequest({@required this.latt, @required this.long})
      : assert(latt != null),
        assert(long != null);
  @override
  List<Object> get props => [latt, long];
}

class WeatherUserEventRefresh extends WeatherEvent {
  final int woeid;
  const WeatherUserEventRefresh({@required this.woeid});
  @override
  List<Object> get props => [woeid];
}
