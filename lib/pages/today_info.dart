import 'package:flutter/material.dart';
import 'package:weather_app/pages/gradient_icon.dart';

class TodayInfo extends StatelessWidget {
  const TodayInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Text(
                  "$index AM",
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(fontSize: 15),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 9),
                  child: GradientIcon(
                      icon: Icon(
                    Icons.circle,
                    color: Colors.white,
                  )),
                ),
                Text(
                  "19°",
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(fontSize: 20),
                )
              ],
            ),
          );
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
