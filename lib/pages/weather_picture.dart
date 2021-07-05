import 'package:flutter/material.dart';
import 'package:weather_app/pages/gradient_icon.dart';

class WeatherPicture extends StatelessWidget {
  const WeatherPicture({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned(
              top: -50,
              right: -100,
              child: GradientIcon(
                icon: Icon(
                  Icons.circle,
                  size: 300,
                  color: Colors.white,
                ),
              )),
          Positioned(
            top: -120,
            right: -140,
            child: Container(
              margin: EdgeInsets.all(200),
              child: GradientIcon(
                icon: Icon(
                  Icons.cloud,
                  size: 140,
                  color: Colors.white,
                ),
                startGradientColor: Colors.blueAccent[100],
                endGradientColor: Colors.indigo[900],
              ),
            ),
          ),
          Positioned(
            top: -190,
            right: -290,
            child: Container(
              margin: EdgeInsets.all(200),
              child: GradientIcon(
                icon: Icon(
                  Icons.cloud,
                  size: 140,
                  color: Colors.white,
                ),
                startGradientColor: Colors.blueAccent[100],
                endGradientColor: Colors.indigo[900],
              ),
            ),
          )
        ],
      ),
    );
  }
}
