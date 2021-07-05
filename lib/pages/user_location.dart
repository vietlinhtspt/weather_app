import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';

class UserLocation extends StatelessWidget {
  final Weather weather;
  const UserLocation({Key key, this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(TiengViet.parse("Hà Nội"));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              color: Colors.grey,
            ),
            Text(
              "Your Location Now",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            )
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 10)),
        Column(
          children: [
            Text(
              "${this.weather.location}, ${this.weather.timezone}",
              style: Theme.of(context).textTheme.headline6,
            )
          ],
        )
      ],
    );
  }
}
