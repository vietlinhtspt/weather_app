import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/weather_search_bloc.dart';
import 'package:weather_app/events/weather_search_event.dart';
import 'package:weather_app/pages/gradient_icon.dart';

class SearchBar extends StatelessWidget {
  final _debouncer = Debouncer(milliseconds: 1000);
  SearchBar({
    Key key,
    @required TextEditingController cityTextController,
  })  : _cityTextController = cityTextController,
        super(key: key);

  final TextEditingController _cityTextController;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              child: GradientIcon(
                icon: Icon(
                  Icons.search,
                  size: 30,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10.0, right: 20),
                child: TextFormField(
                    onChanged: (text) {
                      _debouncer.run(() {
                        //Perform your search
                        print("Search text");
                        if (text != '') {
                          BlocProvider.of<WeatherSearchBloc>(context)
                              .add(WeatherSearchEventSearch(city: text));
                        }
                      });
                    },
                    controller: _cityTextController,
                    decoration: InputDecoration(
                        labelText: 'Enter a city',
                        hintText: 'Example: Chicago')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
