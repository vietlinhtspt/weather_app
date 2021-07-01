import 'package:flutter/material.dart';
import 'package:weather_app/pages/gradientIcon.dart';

class SunItem extends StatelessWidget {
  Icon icon;
  Color startGradientColor;
  Color endGradientColor;
  String title;
  SunItem(
      {Key key,
      @required this.icon,
      @required this.title,
      @required this.startGradientColor,
      @required this.endGradientColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: GradientIcon(
              icon: this.icon,
              startGradientColor: this.startGradientColor,
              endGradientColor: this.endGradientColor),
        ),
        Text(
          this.title,
          style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 17),
        )
      ],
    );
  }
}
