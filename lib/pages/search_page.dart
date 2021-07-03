import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/weather_bloc.dart';
import 'package:weather_app/blocs/weather_search_bloc.dart';
import 'package:weather_app/pages/searchBar.dart';
import 'package:weather_app/pages/suggestItem.dart';
import 'package:weather_app/states/weather_search_state.dart';
import 'package:weather_app/states/weather_state.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _cityTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherSearchBloc, WeatherState>(
        builder: (context, weatherState) {
      return SafeArea(
        child: Column(
          children: [
            SearchBar(cityTextController: _cityTextController),
            // SuggestItem()
            (() {
              if (weatherState is WeatherStateSearchInitial) {
                return Expanded(
                  child: Center(
                      child: Text('Do you want search a location?',
                          style: TextStyle(fontSize: 20))),
                );
              }
              if (weatherState is WeatherStateSearchLoading) {
                return SizedBox(
                    height: 100,
                    child: Center(child: CircularProgressIndicator()));
              }
              // your code here
              if (weatherState is WeatherStateSearchSuccess) {
                final weathers = weatherState.weathers;

                return Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 0.9 / 1,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                        itemCount: weathers.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return SuggestItem(
                            weather: weathers[index],
                          );
                        }),
                  ),
                );
              }
              return Text(
                'Something went wrong',
                style: TextStyle(color: Colors.redAccent, fontSize: 16),
              );
            }())
          ],
        ),
      );
    });
  }
}
