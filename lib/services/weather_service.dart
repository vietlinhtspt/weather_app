import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';

const baseUrl = 'https://www.metaweather.com';
final locationUrl = (city) => '$baseUrl/api/location/search/?query=$city';
final weatherUrl = (locationId) => '$baseUrl/api/location/$locationId';
final locationSearchUrl =
    (latt, long) => '$baseUrl/api/location/search/?lattlong=$latt,$long';

class WeatherServices {
  final http.Client httpClient;
  //constructor
  WeatherServices({@required this.httpClient}) : assert(httpClient != null);
  Future<int> getLocationIdFromCity(String city) async {
    final response = await this.httpClient.get(locationUrl(city));
    if (response.statusCode == 200) {
      final cities = jsonDecode(response.body) as List;
      return (cities.first)['woeid'] ?? Map();
    } else {
      throw Exception('Error getting location id of : $city');
    }
  }

  //LocationId => Weather
  Future<Weather> fetchWeather(int locationId) async {
    final response = await this.httpClient.get(weatherUrl(locationId));
    if (response.statusCode != 200) {
      throw Exception('Error getting weather from locationId: $locationId');
    }
    final weatherJson = jsonDecode(utf8.decode(response.bodyBytes));
    return Weather.fromJson(weatherJson);
  }

  Future<Weather> getWeatherFromCity(String city) async {
    final int locationId = await getLocationIdFromCity(city);
    return fetchWeather(locationId);
  }

  Future<List<Weather>> searchCity(String city) async {
    final response = await this.httpClient.get(locationUrl(city));
    if (response.statusCode == 200) {
      final cities = jsonDecode(response.body) as List;
      final List<Weather> weathers =
          cities.map((e) => Weather.fromSearchResult(e)).toList();
      return weathers ?? List<Weather>();
    } else {
      throw Exception('Error getting location id of : $city');
    }
  }

  Future<Weather> locationSearch(double latt, double long) async {
    print(locationSearchUrl(latt.toString(), long.toString()));
    final response = await this
        .httpClient
        .get(locationSearchUrl(latt.toString(), long.toString()));
    if (response.statusCode == 200) {
      final cities = jsonDecode(response.body) as List;
      // print(cities);
      if ((cities.first)['woeid'] != null) {
        return this.fetchWeather((cities.first)['woeid'] as int);
      } else {
        return Weather();
      }
    } else {
      throw Exception('Error searching location of : $latt $long');
    }
  }
}
