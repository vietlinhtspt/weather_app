import 'package:flutter/material.dart';
import 'package:weather_app/pages/detail_info.dart';
import 'package:weather_app/pages/gradientIcon.dart';
import 'package:weather_app/pages/main_info.dart';
import 'package:weather_app/pages/sun_info.dart';
import 'package:weather_app/pages/today_info.dart';
import 'package:weather_app/pages/weather_picture.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> week_info = [
    "Monday",
    "Tueday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(children: [
        WeatherPicture(),
        SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            MainInfo(),
            SizedBox(height: 50),
            DetailInfo(),
            SizedBox(
              height: 50,
            ),
            SunInfo(),
            SizedBox(height: 50),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 21, vertical: 10),
              child: Text(
                "Today",
                style: TextStyle(
                    color: Colors.blueGrey[600], fontWeight: FontWeight.bold),
              ),
            ),
            TodayInfo(),
            Column(
              children: this.week_info.map((item) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 19),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 150,
                        child: Text(
                          item,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      GradientIcon(icon: Icon(Icons.circle)),
                      Container(
                        child: Row(
                          children: [
                            Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "19°",
                                  style: Theme.of(context).textTheme.headline5,
                                )),
                            Text(
                              "15°",
                              style: Theme.of(context).textTheme.headline6,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }).toList(),
            )
          ]),
        )
      ]),
    );
  }
}
