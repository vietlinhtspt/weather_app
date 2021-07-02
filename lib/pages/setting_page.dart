import 'package:flutter/material.dart';
import 'package:weather_app/pages/detail_info.dart';
import 'package:weather_app/pages/gradientIcon.dart';
import 'package:weather_app/pages/setting_item.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
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
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Column(
                children: [
                  Text(
                    "San Fransisco, California, USA",
                    style: Theme.of(context).textTheme.headline6,
                  )
                ],
              )
            ],
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: GradientIcon(
                icon: Icon(
              Icons.circle,
              size: 170,
            )),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.deepPurple[600]),
            child: Text(
              "Moonlight",
              style:
                  TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 15),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            child: Text(
              "20°C",
              style:
                  Theme.of(context).textTheme.headline5.copyWith(fontSize: 50),
            ),
          ),
          DetailInfo(),
          SettingItem(
            title: "Temperature",
            meansure: "Celcius",
            optionNames: [
              "Celcius",
              "Fahrenheit",
            ],
          ),
          SettingItem(
            title: "Wind Speed",
            meansure: "m/s",
            optionNames: [
              "m/s",
              "km/h",
            ],
          ),
          SettingItem(
            title: "Source",
            meansure: "weather.gov",
            optionNames: ["weather.gov", "weather.vn", "weather.com"],
          )
        ],
      ),
    );
  }
}
