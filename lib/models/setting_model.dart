import 'package:equatable/equatable.dart';

enum TemperatureMeansure { celcius, fahrenheit }
enum WindSpeedMeansure { mPerS, kmPerS }
enum SourceDataMeansure { weatherDotgov }

var formatedTemperatureMeansure = {
  TemperatureMeansure.celcius: "Celicus",
  TemperatureMeansure.fahrenheit: "Fahrenheit"
};

var formatedWindSpeedMeansure = {
  WindSpeedMeansure.kmPerS: "km/h",
  WindSpeedMeansure.mPerS: "m/s"
};

var formatedSourceDataMeansure = {
  SourceDataMeansure.weatherDotgov: "weather.gov"
};

final standardizeTemperature =
    (int temp, TemperatureMeansure temperatureMeansure) =>
        temperatureMeansure == TemperatureMeansure.celcius
            ? temp
            : (temp * 1.8 + 32).round();

final standardizeWindSpeed =
    (int windSpeed, WindSpeedMeansure windSpeedMeansure) =>
        windSpeedMeansure == WindSpeedMeansure.kmPerS
            ? windSpeed
            : (windSpeed * 1000 / 3600).round();

final formatedTemperature = (int temp,
        TemperatureMeansure temperatureMeansure) =>
    "${standardizeTemperature(temp, temperatureMeansure)}${temperatureMeansure == TemperatureMeansure.celcius ? '°C' : '°F'}";

final formatedWindSpeed = (int windSpeed,
        WindSpeedMeansure windSpeedMeansure) =>
    "${standardizeWindSpeed(windSpeed, windSpeedMeansure)} ${windSpeedMeansure == WindSpeedMeansure.kmPerS ? 'km/h' : 'm/s'}";

class Setting extends Equatable {
  final TemperatureMeansure temperatureMeansure;
  final WindSpeedMeansure windSpeedMeansure;
  final SourceDataMeansure sourceDataMeansure;

  const Setting(
      {this.temperatureMeansure,
      this.windSpeedMeansure,
      this.sourceDataMeansure});

  factory Setting.initial() {
    return Setting(
      sourceDataMeansure: SourceDataMeansure.weatherDotgov,
      windSpeedMeansure: WindSpeedMeansure.kmPerS,
      temperatureMeansure: TemperatureMeansure.celcius,
    );
  }

  Setting initial() {
    return Setting(
      sourceDataMeansure: SourceDataMeansure.weatherDotgov,
      windSpeedMeansure: WindSpeedMeansure.kmPerS,
      temperatureMeansure: TemperatureMeansure.celcius,
    );
  }

  @override
  List<Object> get props => [
        this.temperatureMeansure,
        this.windSpeedMeansure,
        this.sourceDataMeansure
      ];
  Setting copyWithChange(
      {TemperatureMeansure newTemperatureMeansure,
      WindSpeedMeansure newWindSpeedMeansure,
      SourceDataMeansure newSourceDataMeansure}) {
    return Setting(
        temperatureMeansure: newTemperatureMeansure ?? this.temperatureMeansure,
        windSpeedMeansure: newWindSpeedMeansure ?? this.windSpeedMeansure,
        sourceDataMeansure: newSourceDataMeansure ?? this.sourceDataMeansure);
  }
}
