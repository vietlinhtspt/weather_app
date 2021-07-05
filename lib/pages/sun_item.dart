import 'package:flutter/material.dart';
import 'package:weather_app/pages/gradient_icon.dart';


class SunItem extends StatelessWidget {
  final Icon icon;
  final Color startGradientColor;
  final Color endGradientColor;
  final String title;
  const SunItem(
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
