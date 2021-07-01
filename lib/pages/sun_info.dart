import 'package:flutter/material.dart';
import 'package:weather_app/pages/sun_item.dart';

class SunInfo extends StatelessWidget {
  const SunInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SunItem(
            icon: Icon(Icons.wb_sunny),
            title: "07:00 AM",
            startGradientColor: Colors.yellow[600],
            endGradientColor: Colors.yellow[700],
          ),
          SunItem(
            icon: Icon(Icons.circle),
            title: "06:00 PM",
            startGradientColor: Colors.yellow[900],
            endGradientColor: Colors.amber[900],
          )
        ],
      ),
    );
  }
}
