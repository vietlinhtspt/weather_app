import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:hive_flutter/hive_flutter.dart';

part 'weather_model.g.dart';

@HiveType(typeId: 1)
class Weather extends HiveObject {
  final WeatherCondition weatherCondition;

  final String formattedCondition;

  final double minTemp;

  final double temp;

  final double maxTemp;
  @HiveField(0)
  final int locationId;

  final String created;

  final double windSpeed;

  final DateTime lastUpdated;
  @HiveField(1)
  final String location;

  final int humidity;
  @HiveField(2)
  final String timezone;

  final double airPressure;

  final List<FutureWeather> futureWeathers;

  //constructor
  Weather(
      {this.weatherCondition,
      this.formattedCondition,
      this.minTemp,
      this.temp,
      this.maxTemp,
      this.locationId,
      this.created,
      this.windSpeed,
      this.lastUpdated,
      this.location,
      this.humidity,
      this.timezone,
      this.airPressure,
      this.futureWeathers});
  @override
  List<Object> get props => [
        weatherCondition,
        formattedCondition,
        minTemp,
        temp,
        maxTemp,
        locationId,
        created,
        windSpeed,
        lastUpdated,
        location,
        humidity,
        timezone,
        airPressure,
        futureWeathers
      ];
  //convert from JSON to Weather object
/*
consolidated_weather": [
    {
      "id": 5001437304061952,
      "weather_state_name": "Light Cloud",
      "weather_state_abbr": "lc",
      "wind_direction_compass": "SSE",
      "created": "2020-07-26T00:22:18.967978Z",
      "applicable_date": "2020-07-25",
      "min_temp": 22.825,
      "max_temp": 31.585,
      "the_temp": 32.2,
      "wind_speed": 4.388510937739601,
      "wind_direction": 165.1056162097894,
      "air_pressure": 1018.5,
      "humidity": 56,
      "visibility": 15.249070428696413,
      "predictability": 70
    },
    ...
 */
  factory Weather.fromJson(dynamic jsonObject) {
    final consolidatedWeather = jsonObject['consolidated_weather'][0];
    final futureWeathers = getFutureWeathers(jsonObject);

    return Weather(
      weatherCondition: _mapStringToWeatherCondition(
              consolidatedWeather['weather_state_abbr']) ??
          '',
      formattedCondition: consolidatedWeather['weather_state_name'] ?? '',
      minTemp: consolidatedWeather['min_temp'] as double,
      temp: consolidatedWeather['the_temp'] as double,
      maxTemp: consolidatedWeather['max_temp'] as double,
      locationId:
          jsonObject['woeid'] as int, //Where On Earth Identifier = woeid
      created: consolidatedWeather['created'],
      lastUpdated: DateTime.now(),
      location: jsonObject['title'],
      airPressure: consolidatedWeather['air_pressure'] as double,
      windSpeed: consolidatedWeather['wind_speed'] as double,
      humidity: consolidatedWeather['humidity'],
      timezone: jsonObject["timezone"].split("/")[0],
      futureWeathers: futureWeathers,
    );
  }

  factory Weather.fromSearchResult(Map item) {
    return Weather(locationId: item['woeid'] as int, location: item['title']);
  }

  static List<FutureWeather> getFutureWeathers(dynamic jsonObject) {
    final List<FutureWeather> futureWeathers = List<FutureWeather>();
    for (var consolidatedWeather in jsonObject['consolidated_weather']) {
      var dateTimes = consolidatedWeather["applicable_date"].split("-");
      futureWeathers.add(
        FutureWeather(
          dateTime: DateTime.utc(int.parse(dateTimes[0]),
              int.parse(dateTimes[1]), int.parse(dateTimes[2])),
          weatherCondition: _mapStringToWeatherCondition(
                  consolidatedWeather['weather_state_abbr']) ??
              '',
          formattedCondition: consolidatedWeather['weather_state_name'] ?? '',
          minTemp: consolidatedWeather['min_temp'] as double,
          maxTemp: consolidatedWeather['max_temp'] as double,
        ),
      );

      // print(consolidatedWeather["applicable_date"].split());
    }
    return futureWeathers;
  }

  static WeatherCondition _mapStringToWeatherCondition(String inputString) {
    Map<String, WeatherCondition> map = {
      'sn': WeatherCondition.snow,
      'sl': WeatherCondition.sleet,
      'h': WeatherCondition.hail,
      't': WeatherCondition.thunderstorm,
      'hr': WeatherCondition.heavyRain,
      'lr': WeatherCondition.lightRain,
      's': WeatherCondition.showers,
      'hc': WeatherCondition.heavyCloud,
      'lc': WeatherCondition.lightCloud,
      'c': WeatherCondition.clear
    };
    return map[inputString] ?? WeatherCondition.unknown;
  }

  Weather copyWith({
    final WeatherCondition weatherCondition,
    final String formattedCondition,
    final double minTemp,
    final double temp,
    final double maxTemp,
    final int locationId,
    final String created,
    final double windSpeed,
    final DateTime lastUpdated,
    final String location,
    final int humidity,
    final String timezone,
    final double airPressure,
    final List<FutureWeather> futureWeathers,
  }) {
    return Weather(
        weatherCondition: weatherCondition ?? this.weatherCondition,
        formattedCondition: formattedCondition ?? this.formattedCondition,
        minTemp: minTemp ?? this.minTemp,
        temp: temp ?? this.temp,
        maxTemp: maxTemp ?? this.maxTemp,
        locationId: locationId ?? this.locationId,
        created: created ?? this.created,
        windSpeed: windSpeed ?? this.windSpeed,
        lastUpdated: lastUpdated ?? this.lastUpdated,
        location: location ?? this.location,
        humidity: humidity ?? this.humidity,
        timezone: timezone ?? this.timezone,
        airPressure: airPressure ?? this.airPressure,
        futureWeathers: futureWeathers ?? this.futureWeathers);
  }
}

enum WeatherCondition {
  snow,
  sleet,
  hail,
  thunderstorm,
  heavyRain,
  lightRain,
  showers,
  heavyCloud,
  lightCloud,
  clear,
  unknown
}

class FutureWeather {
  final DateTime dateTime;
  final String formattedCondition;
  final WeatherCondition weatherCondition;
  final double minTemp;
  final double maxTemp;
  const FutureWeather(
      {this.dateTime,
      this.formattedCondition,
      this.weatherCondition,
      this.maxTemp,
      this.minTemp});
}
